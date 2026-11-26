/* Numerical checks for the sharp scalar LDP frontier.
 * Self-contained ECMAScript: no packages, network, or symbolic assumptions.
 * Run: node code/verify_frontier.js > results/numerical_verification.json
 * The same runVerification implementation was executed in a V8 tool runtime.
 * Floating-point evidence only; no interval certificate or all-channel proof.
 */
function simpsonIntegrate(f,a,b,tol=1e-12,maxDepth=24) {
  if(a===b) return 0;
  if(a>b) return -simpsonIntegrate(f,b,a,tol,maxDepth);
  const m=(a+b)/2,fa=f(a),fm=f(m),fb=f(b);
  function rec(a,b,fa,fm,fb,S,tol,depth) {
    const m=(a+b)/2,l=(a+m)/2,r=(m+b)/2,fl=f(l),fr=f(r);
    const L=(m-a)*(fa+4*fl+fm)/6,R=(b-m)*(fm+4*fr+fb)/6;
    const d=L+R-S;
    if(depth===0 || Math.abs(d)<=15*tol) return L+R+d/15;
    return rec(a,m,fa,fl,fm,L,tol/2,depth-1)+rec(m,b,fm,fr,fb,R,tol/2,depth-1);
  }
  return rec(a,b,fa,fm,fb,(b-a)*(fa+4*fm+fb)/6,tol,maxDepth);
}
const normalDensity=x=>Math.exp(-x*x/2)/Math.sqrt(2*Math.PI);
const laws=[
  {name:"standard_gaussian",variance:1,halfSupport:null},
  {name:"uniform_minus_sqrt3_sqrt3",variance:1,halfSupport:Math.sqrt(3)}
];
function density(law,x) {
  return law.halfSupport===null ? normalDensity(x) :
    (Math.abs(x)<=law.halfSupport ? 1/(2*law.halfSupport) : 0);
}
function g(law,x,lambda) {
  return Math.cbrt(density(law,x)/(6*(law.variance+x*x+lambda)));
}
function integrateSym(law,f,tol=2e-12) {
  return 2*simpsonIntegrate(f,0,law.halfSupport===null?14:law.halfSupport,tol/2);
}
function mass(law,lambda) {return integrateSym(law,x=>g(law,x,lambda));}
function reference(law,kappa) {
  const critical=mass(law,0);let lambda=0;
  if(kappa<critical) {
    let lo=0,hi=1;while(mass(law,hi)>kappa)hi*=2;
    for(let i=0;i<65;i++) {
      const mid=(lo+hi)/2;if(mass(law,mid)>kappa)lo=mid;else hi=mid;
    }
    lambda=(lo+hi)/2;
  }
  const energy=integrateSym(law,x=>{
    const z=law.variance+x*x+lambda,p13=Math.cbrt(density(law,x));
    return p13*(Math.pow(6*z,2/3)/12+(law.variance+x*x)/Math.cbrt(6*z));
  });
  const dual=(3/(2*Math.cbrt(6)))*integrateSym(law,x=>
    Math.cbrt(density(law,x))*Math.pow(law.variance+x*x+lambda,2/3))-lambda*kappa;
  return {law:law.name,kappa,critical_kappa:critical,lagrange_multiplier:lambda,
    cell_density_mass:mass(law,lambda),frontier_constant:energy,
    primal_dual_abs_difference:Math.abs(energy-dual)};
}
const GL16_X=[.09501250983763744,.2816035507792589,.4580167776572274,.6178762444026438,.755404408355003,.8656312023878318,.9445750230732326,.9894009349916499];
const GL16_W=[.1894506104550685,.1826034150449236,.16915651939500254,.14959598881657673,.12462897125553387,.09515851168249278,.06225352393864789,.027152459411754096];
function gl16(f,a,b) {
  const mid=(a+b)/2,half=(b-a)/2;let result=0;
  for(let i=0;i<8;i++)result+=GL16_W[i]*(f(mid-half*GL16_X[i])+f(mid+half*GL16_X[i]));
  return result*half;
}
function makeCells(law,c,kappa,lambda) {
  const gaussian=law.halfSupport===null,T=gaussian?Math.sqrt((5/3)*Math.log(c)):law.halfSupport;
  const K=Math.max(gaussian?3:1,Math.floor(kappa*Math.cbrt(c)));
  const totalG=2*simpsonIntegrate(x=>g(law,x,lambda),0,T,3e-13);
  const n=Math.min(K-(gaussian?2:0),Math.ceil(Math.cbrt(c)*totalG));
  const edges=Array(n+1);edges[0]=-T;edges[n]=T;
  // Use exact symmetry to avoid a spurious nonzero global mean.
  for(let j=1;j<=Math.floor(n/2);j++) {
    const target=totalG*(.5-j/n);
    let lo=0,hi=T;
    if(target===0)hi=0;
    else for(let k=0;k<44;k++) {
      const mid=(lo+hi)/2;
      if(simpsonIntegrate(x=>g(law,x,lambda),0,mid,2e-13)<target)lo=mid;else hi=mid;
    }
    const x=(lo+hi)/2;edges[j]=-x;edges[n-j]=x;
  }
  const cells=[];
  for(let j=0;j<n;j++) {
    const a=edges[j],b=edges[j+1];
    if(!(b>a))throw Error("nonpositive cell width");
    let p,mu,D;
    if(gaussian) {
      p=gl16(normalDensity,a,b);
      const m=gl16(x=>x*normalDensity(x),a,b);mu=m/p;
      D=gl16(x=>(x-mu)*(x-mu)*normalDensity(x),a,b);
    } else {p=(b-a)/(2*T);mu=(a+b)/2;D=p*(b-a)*(b-a)/12;}
    cells.push({p,mu,D});
  }
  if(gaussian) {
    const p=simpsonIntegrate(normalDensity,T,14,1e-19);
    const mu=normalDensity(T)/p;
    const D=simpsonIntegrate(x=>(x-mu)*(x-mu)*normalDensity(x),T,14,1e-20);
    cells.unshift({p,mu:-mu,D});cells.push({p,mu,D});
  }
  return {K,n,cells,T};
}
function experiment(law,c,kappa,ref) {
  const {K,n,cells,T}=makeCells(law,c,kappa,ref.lagrange_multiplier);
  const k=cells.length,pSum=cells.reduce((a,x)=>a+x.p,0);
  const D=cells.reduce((a,x)=>a+x.D,0);
  const privacy=cells.reduce((a,x)=>a+x.mu*x.mu*x.p/(1+c*x.p),0);
  const delta=(D+k*law.variance/c+privacy)/(1+k/c);
  const info=(c*c/(c+k))*cells.reduce((a,x)=>a+(x.mu*x.p)**2/(1+c*x.p),0);
  const delta2=D+k/(c+k)*(law.variance-D)+c/(c+k)*privacy;
  if(k>K || cells.some(x=>!(x.p>0)) || Math.abs(pSum-1)>5e-11)throw Error("mechanism check failed");
  return {law:law.name,c,epsilon:Math.log1p(c),kappa,output_budget:K,
    actual_outputs:k,interior_cells:n,truncation:law.halfSupport===null?T:null,
    total_cell_probability:pSum,distortion:D,loss:delta,
    scaled_loss:Math.pow(c,2/3)*delta,frontier_constant:ref.frontier_constant,
    scaled_loss_relative_difference:Math.pow(c,2/3)*delta/ref.frontier_constant-1,
    identity_abs_error:Math.max(Math.abs(delta-delta2),Math.abs(delta-(law.variance-info))),
    respects_output_cap:k<=K};
}
function runVerification() {
  const refs=[],experiments=[];
  for(const law of laws) {
    const critical=mass(law,0);
    for(const kappa of [.5,1,critical,2]) {
      const ref=reference(law,kappa);refs.push(ref);
      for(const c of [1e3,1e6,1e9])experiments.push(experiment(law,c,kappa,ref));
    }
  }
  const summary={
    continuous_cases:experiments.length,
    all_output_caps_respected:experiments.every(x=>x.respects_output_cap),
    max_probability_mass_error:Math.max(...experiments.map(x=>Math.abs(x.total_cell_probability-1))),
    max_information_identity_error:Math.max(...experiments.map(x=>x.identity_abs_error)),
    max_primal_dual_error:Math.max(...refs.map(x=>x.primal_dual_abs_difference)),
    max_relative_limit_gap_at_c_1e9:Math.max(...experiments.filter(x=>x.c===1e9).map(x=>Math.abs(x.scaled_loss_relative_difference)))
  };
  if(summary.max_information_identity_error>1e-10 || summary.max_primal_dual_error>1e-9)throw Error("numerical consistency failed");
  return {schema_version:1,
    provenance:"New implementation executed after the original Python workspace became unavailable; not a reconstruction of its missing raw logs.",
    engine:"ECMAScript / V8, IEEE-754 binary64",
    is_rigorous_interval_certificate:false,
    all_channel_proof:false,
    gaussian_integration_cutoff:14,
    integration_note:"Adaptive Simpson and 16-point Gauss-Legendre; tolerances are algorithmic, not certified enclosures. Gaussian tails beyond 14 are numerically omitted.",
    references:refs,experiments,verification_summary:summary};
}
if(typeof module!=="undefined")module.exports={runVerification,reference,makeCells,experiment,laws};
if(typeof require!=="undefined" && require.main===module)console.log(JSON.stringify(runVerification(),null,2));
