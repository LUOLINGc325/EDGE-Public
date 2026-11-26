/* Reproducible numerical diagnostics, not a proof or global optimizer.
   Run with a modern JavaScript runtime, e.g. node gaussian_diagnostics.js.
   No external packages, files, network, or random seed are required. */
function gaussLegendre(n) {
  const x=[], w=[];
  for(let i=1;i<=n;i++){
    let z=Math.cos(Math.PI*(i-.25)/(n+.5)), p=0, dp=0;
    for(let k=0;k<30;k++){
      let p0=1,p1=z;
      for(let j=2;j<=n;j++){let p2=((2*j-1)*z*p1-(j-1)*p0)/j;p0=p1;p1=p2;}
      p=n===1?z:p1;
      const pm=n===1?1:p0;
      dp=n*(z*p-pm)/(z*z-1);
      const nz=z-p/dp;
      if(Math.abs(nz-z)<3e-16){z=nz;break;}z=nz;
    }
    let p0=1,p1=z;
    for(let j=2;j<=n;j++){let p2=((2*j-1)*z*p1-(j-1)*p0)/j;p0=p1;p1=p2;}
    dp=n*(z*(n===1?z:p1)-(n===1?1:p0))/(z*z-1);
    x.push(z);w.push(2/((1-z*z)*dp*dp));
  }
  return {x,w};
}
function gammaHalfTwice(k) {
  if(k===1)return Math.sqrt(Math.PI);
  if(k===2)return 1;
  return (k/2-1)*gammaHalfTwice(k-2);
}
function unitVolume(d){return Math.PI**(d/2)/gammaHalfTwice(d+2);}
function moments(d,a,r,n) {
  const g=gaussLegendre(n), norm=(2*Math.PI)**(-d/2);
  let i0=0,i1=0,i2=0;
  if(d===1){
    for(let j=0;j<n;j++){
      const t=g.x[j],b=g.w[j]*norm*Math.exp(-((a+r*t)**2)/2);
      i0+=b;i1+=b*t;i2+=b*t*t;
    }
  } else {
    const surface=2*Math.PI**((d-1)/2)/gammaHalfTwice(d-1);
    for(let j=0;j<n;j++){
      const theta=g.x[j]*Math.PI/2,st=Math.sin(theta),ct=Math.cos(theta);
      for(let k=0;k<n;k++){
        const u=(g.x[k]+1)/2, radial2=st*st+ct*ct*u*u;
        const b=g.w[j]*Math.PI/2*g.w[k]/2*surface*ct**d*u**(d-2)*
          norm*Math.exp(-(a*a+2*a*r*st+r*r*radial2)/2);
        i0+=b;i1+=b*st;i2+=b*radial2;
      }
    }
  }
  return {q:r**d*i0,mu:a+r*i1/i0,T:r*r*(i2/i0-(i1/i0)**2)};
}
function gainScaled(d,k,lambda,a,r,n) {
  const m=moments(d,a,r,n);
  return m.q/lambda**(d/2)*(m.mu*m.mu/(1-m.q)+k-(1-lambda)*m.T/lambda);
}
function coefficient(d,k) {
  const p=(d+2)/2,peak=k<d+2?(d+2)**p*Math.exp(-(d+2-k)/2):k**p;
  return 2*unitVolume(d)/(d+2)*(2*Math.PI)**(-d/2)*peak;
}
function runDiagnostics(){
  const rows=[];
  let refinement=0;
  for(const d of [1,2,3,5])for(const k of [0,1,d+2,d+3]){
    const a=Math.sqrt(Math.max(0,d+2-k)),L=Math.sqrt(a*a+k),limit=coefficient(d,k);
    for(const lambda of [1e-2,1e-3,1e-4]){
      const r=Math.sqrt(lambda)*L;
      const gain=gainScaled(d,k,lambda,a,r,64);
      const gain32=gainScaled(d,k,lambda,a,r,32);
      refinement=Math.max(refinement,Math.abs(gain-gain32)/Math.max(1,Math.abs(gain)));
      rows.push({d,kappa:k,lambda,design_center_norm:a,design_radius:r,
        normalized_design_gain:gain,predicted_limit:limit,ratio:gain/limit});
    }
  }
  const pi=Math.PI,reduced=7/8-3/(2*pi),gap=.5-reduced;
  if(!(gap>0 && reduced<.5))throw new Error("Counterexample sign check failed");
  if(!(refinement<1e-10))throw new Error("Quadrature refinement check failed");
  const worstSmall=Math.max(...rows.filter(x=>x.lambda===1e-4).map(x=>Math.abs(x.ratio-1)));
  if(!(worstSmall<.02))throw new Error("Small-lambda diagnostic outside declared tolerance");
  return {
    kind:"diagnostic_not_proof",
    method:"Deterministic Gauss-Legendre integration of local moments; 32 vs 64 nodes in each direction; no optimization.",
    interpretation:"Each evaluated ball is the explicit fixed-profile design. Values are feasible gains, never asserted global numerical optima.",
    counterexample:{even_lower_bound:.5,sign_reduced_risk:reduced,full_risk:4+reduced,strict_gap:gap,exact_gap:"3/(2*pi)-3/8"},
    checks:{quadrature_refinement_max_scaled_difference:refinement,tolerance:1e-10,
      worst_relative_error_at_lambda_1e_4:worstSmall,diagnostic_tolerance:.02},
    rows
  };
}
const diagnosticResults=runDiagnostics();
if(typeof console!=="undefined" && typeof console.log==="function")
  console.log(JSON.stringify(diagnosticResults,null,2));
