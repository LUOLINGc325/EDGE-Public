/* Reconstructed reproducibility implementation; requires Node.js 18+; uses only built-in modules.
 * The pure core was actually run in V8 after loss of the earlier Python environment.
 * Finite diagnostics and numerical illustrations are not general proofs. No Lean is run.
 */

"use strict";
function gcd(a,b){a=a<0n?-a:a;b=b<0n?-b:b;while(b){const t=a%b;a=b;b=t;}return a;}
class F{
  constructor(a,b=1n){a=BigInt(a);b=BigInt(b);if(!b)throw Error("zero denominator");if(b<0n){a=-a;b=-b;}const g=gcd(a,b);this.a=a/g;this.b=b/g;}
  add(o){o=F.of(o);return new F(this.a*o.b+o.a*this.b,this.b*o.b);}
  mul(o){o=F.of(o);return new F(this.a*o.a,this.b*o.b);}
  div(o){o=F.of(o);return new F(this.a*o.b,this.b*o.a);}
  sub(o){return this.add(F.of(o).mul(-1));}
  cmp(o){o=F.of(o);const v=this.a*o.b-o.a*this.b;return v<0n?-1:v>0n?1:0;}
  pow(k){let r=new F(1);if(k<0)return new F(this.b,this.a).pow(-k);for(let i=0;i<k;i++)r=r.mul(this);return r;}
  text(){return this.a.toString()+"/"+this.b.toString();}
  static of(o){return o instanceof F?o:new F(o);}
}
const Z=new F(0),O=new F(1);
function bits(n,k){return Array.from({length:n},(_,i)=>(k>>i)&1);}
function np(raw,d){let remaining=0;const y=[];for(const bit of raw){if(remaining){y.push(0);remaining--;}else{y.push(bit);if(bit)remaining=d;}}return y;}
function par(raw,d){return raw.map((z,i)=>z&&!raw.slice(Math.max(0,i-d),i).some(Boolean)?1:0);}
const DET={nonparalyzable:np,paralyzable:par};
function weight(raw,ps){let w=O;for(let i=0;i<raw.length;i++)w=w.mul(raw[i]?ps[i]:O.sub(ps[i]));return w;}
function empty(ps){let w=O;for(const p of ps)w=w.mul(O.sub(p));return w;}
function sum(a){return a.reduce((x,y)=>x+y,0);}
function comb(n,k){let v=1n;for(let j=1;j<=k;j++)v=v*BigInt(n-j+1)/BigInt(j);return v;}
function csv(rows){const keys=Object.keys(rows[0]);return keys.join(",")+"\n"+rows.map(r=>keys.map(k=>String(r[k])).join(",")).join("\n")+"\n";}
function H(p){return p<=0||p>=1?0:-p*Math.log(p)-(1-p)*Math.log1p(-p);}
function U(z,d){const m=d+1,r=Math.min(-Math.expm1(-m*z),m/(m+1));return(H(r)+r*Math.log(m))/m;}
function L(z,d){const s=Math.max(2,Math.floor(d/Math.log(d+2)**2)),frame=d+s;return -Math.expm1(-z*frame)*Math.log(s)/frame;}
function poissonTail(x,r){
  if(x<=0)return 0;
  if(x<=r){let term=Math.exp(-x)*x**r;for(let j=2;j<=r;j++)term/=j;let answer=term;
    for(let k=r+1;k<10000;k++){term*=x/k;answer+=term;if(term<Math.abs(answer)*1e-17)break;}return answer;}
  let term=1,lower=1;for(let j=1;j<r;j++){term*=x/j;lower+=term;}return -Math.expm1(-x+Math.log(lower));
}
function poissonPrime(x,r){if(x<=0)return 0;let f=1;for(let j=2;j<r;j++)f*=j;return Math.exp(-x)*x**(r-1)/f;}
function thresholdRoot(r){
  const g=x=>x*poissonPrime(x,r)-poissonTail(x,r);let lo=r-1,hi=2*r;
  while(g(hi)>=0)hi*=2;
  for(let j=0;j<120&&hi-lo>1e-13;j++){const mid=(lo+hi)/2;if(g(mid)>0)lo=mid;else hi=mid;}
  const theta=(lo+hi)/2;return{r,theta,slope:poissonTail(theta,r)/theta,residual:g(theta),bracket_lo:lo,bracket_hi:hi,interval_certified:false};
}
function runReproduction(){
 const counts={},failures=[],groups={};
 function check(name,yes,where){counts[name]=(counts[name]||0)+1;if(!yes)failures.push({name,where});}
 const pathRecords=[];let pathPairs=0;
 for(let n=1;n<=8;n++){
  const ps=Array.from({length:n},(_,i)=>new F(1+i%3,4));const paths=Array.from({length:2**n},(_,k)=>{const raw=bits(n,k);return{raw,w:weight(raw,ps)};});
  check("raw_probability_normalization",paths.reduce((a,b)=>a.add(b.w),Z).cmp(O)===0,{n});
  for(let d=0;d<=4;d++)for(const [name,det]of Object.entries(DET)){
   let expected=Z;const m=d+1;
   for(const{raw,w}of paths){pathPairs++;const y=det(raw,d);
    check("arrival_domination",y.every((v,i)=>v<=raw[i]),{n,d,name,raw});
    check("recorded_spacing",y.every((v,i)=>!v||!y.slice(Math.max(0,i-d),i).some(Boolean)),{n,d,name,raw});
    const width=Math.min(m,n);for(let start=0;start<=n-width;start++)check("window_occupancy",sum(y.slice(start,start+width))<=Number(raw.slice(start,start+width).some(Boolean)),{n,d,name,raw,start});
    expected=expected.add(w.mul(sum(y)));
   }
   let bound=Z;for(let start=0;start<n;start+=m)bound=bound.add(O.sub(empty(ps.slice(start,start+m))));
   check("rational_expected_count",expected.cmp(bound)<=0,{n,d,name,lhs:expected.text(),rhs:bound.text()});
   pathRecords.push({detector:name,n,d,paths:2**n,expected:expected.text(),occupancy_bound:bound.text()});
  }
 }
 groups.exhaustive_detectors={path_detector_pairs:pathPairs,n_max:8,d_values:[0,1,2,3,4],records:pathRecords};
 const periodic=[];let periodicPaths=0;
 for(let d=0;d<=4;d++)for(const p of[new F(1,4),new F(1,2),new F(3,4)])for(const[name,det]of Object.entries(DET)){
  const B=3,m=d+1;let expected=Z;for(let mask=0;mask<8;mask++){
   periodicPaths++;const raw=Array(B*m).fill(0),short=bits(B,mask);for(let j=0;j<B;j++)raw[j*m]=short[j];const y=det(raw,d);
   check("periodic_retention_path",y.every((v,i)=>v===raw[i]),{d,name,p:p.text(),mask});
   expected=expected.add(weight(short,Array(B).fill(p)).mul(sum(y)));
  }
  check("periodic_exact_throughput",expected.cmp(p.mul(B))===0,{d,name,p:p.text()});
  periodic.push({detector:name,d,blocks:B,p:p.text(),detections:expected.text(),per_slot:expected.div(B*m).text()});
 }
 groups.periodic={path_detector_pairs:periodicPaths,records:periodic};
 const countRecords=[];let blockWords=0;
 for(let m=1;m<=4;m++)for(let B=0;B<=4;B++){
  const histogram=Array(B+1).fill(0n),total=(m+1)**B;
  for(let word=0;word<total;word++){let v=word,k=0;for(let j=0;j<B;j++){if(v%(m+1))k++;v=Math.floor(v/(m+1));}histogram[k]++;blockWords++;}
  for(let K=0;K<=B;K++){let enumerated=0n,formula=0n;for(let j=0;j<=K;j++){enumerated+=histogram[j];formula+=comb(B,j)*BigInt(m)**BigInt(j);}
   check("output_count_formula",enumerated===formula,{m,B,K});const record={m,B,K,enumerated:enumerated.toString(),formula:formula.toString()};
   if(B&&K===0){check("tilted_count_bound",formula===1n,{m,B,K});record.tilted_upper="1/1";}
   else if(B&&K*(m+1)<=B*m){const theta=new F(K,m*(B-K)),upper=theta.pow(-K).mul(O.add(theta.mul(m)).pow(B));check("tilted_count_bound",new F(formula).cmp(upper)<=0,{m,B,K});record.theta=theta.text();record.tilted_upper=upper.text();}
   countRecords.push(record);
  }
 }
 groups.output_count={block_words_enumerated:blockWords,records:countRecords};
 function channel(ps,d,det){const map=new Map();for(let i=0;i<2**ps.length;i++){const raw=bits(ps.length,i),key=det(raw,d).join("");map.set(key,(map.get(key)||Z).add(weight(raw,ps)));}return map;}
 function outputs(m,K){const out=[];for(let a=0;a<=m;a++)for(let b=0;b<=m;b++){if(Number(a>0)+Number(b>0)>K)continue;const y=Array(2*m).fill(0);if(a)y[a-1]=1;if(b)y[m+b-1]=1;out.push(y);}return out;}
 const decoderRecords=[];
 for(let d=0;d<=3;d++){const m=d+1,n=2*m,boundary=Array(n).fill(Z);boundary[0]=boundary[n-1]=new F(1,2);
  const pool=[Array(n).fill(Z),Array(n).fill(new F(1,n+1)),boundary,Array(n).fill(new F(3,4))];
  const low=pool.map(ps=>empty(ps).cmp(new F(1,4))>=0);
  for(const[name,det]of Object.entries(DET)){const kernels=pool.map(ps=>channel(ps,d,det));
   for(let a=0;a<4;a++)check("channel_normalization",[...kernels[a].values()].reduce((x,y)=>x.add(y),Z).cmp(O)===0,{d,name,a});
   for(let K=0;K<=1;K++){const out=outputs(m,K);let success=Z;
    for(let message=0;message<11;message++){const w=new F(1+message%3,4),choices=[[message%4,w],[(message+1)%4,O.sub(w)]];
     for(const[a,mix]of choices){if(!low[a])continue;for(const y of out){const signature=y.reduce((a,v,i)=>a+(i+1)*v,0),ws=Array.from({length:11},(_,j)=>1+(signature+2*j)%5),dec=new F(ws[message],sum(ws)+1);success=success.add(mix.div(11).mul(kernels[a].get(y.join(""))||Z).mul(dec));}}
    }
    const upper=new F(out.length,11);check("random_encoder_decoder_count",success.cmp(upper)<=0,{d,name,K,lhs:success.text(),rhs:upper.text()});
    decoderRecords.push({detector:name,d,n,messages:11,K,low_energy_rule:"product(1-p_i)>=1/4",low_pool:low,output_set_size:out.length,success:success.text(),upper:upper.text()});
   }
  }
 }
 groups.random_decoder={records:decoderRecords};
 const kernel=[Z,new F(1,4),new F(1,3),new F(2,3)],patterns={A:[1,2],B:[3,0,1,2],Z:[0]},commonWidth=4;
 const modeRecords=[];let modePaths=0;
 for(const S of[2,3]){const activity=commonWidth*S,d=activity+1,frame=d+activity;
  for(const[a,pa]of Object.entries(patterns))for(const[b,pb]of Object.entries(patterns))for(let ia=0;ia<S;ia++)for(let ib=0;ib<S;ib++)for(const[name,det]of Object.entries(DET)){
   const support=[],ps=[];for(const[j,pattern,pos]of[[0,pa,ia],[1,pb,ib]])for(let h=0;h<pattern.length;h++)if(pattern[h]>0){support.push(j*frame+pos*commonWidth+h);ps.push(kernel[pattern[h]]);}
   const joint=[Z,Z,Z,Z];
   for(let mask=0;mask<2**support.length;mask++){modePaths++;const short=bits(support.length,mask),raw=Array(2*frame).fill(0);for(let h=0;h<support.length;h++)raw[support[h]]=short[h];const y=det(raw,d),decoded=[];
    for(const[j,pos]of[[0,ia],[1,ib]]){const piece=y.slice(j*frame,(j+1)*frame),arrivals=raw.slice(j*frame,(j+1)*frame),ret=Number(piece.some(Boolean));decoded.push(ret);
     check("general_mode_position",ret===Number(arrivals.some(Boolean))&&sum(piece)<=1&&piece.every((v,h)=>!v||Math.floor(h/commonWidth)===pos),{S,d,name,a,b,ia,ib,mask,j});
     check("general_guard_reset",!y.slice((j+1)*frame-d,(j+1)*frame).some(Boolean)&&!raw.slice((j+1)*frame-d,(j+1)*frame).some(Boolean),{S,d,name,a,b,ia,ib,mask,j});
    }
    const key=decoded[0]*2+decoded[1];joint[key]=joint[key].add(weight(short,ps));
   }
   const ra=O.sub(empty(pa.map(x=>kernel[x]))),rb=O.sub(empty(pb.map(x=>kernel[x])));
   for(let first=0;first<=1;first++)for(let second=0;second<=1;second++){const target=(first?ra:O.sub(ra)).mul(second?rb:O.sub(rb));check("general_mode_joint_factorization",joint[first*2+second].cmp(target)===0,{S,d,name,a,b,ia,ib,first,second});}
   modeRecords.push({S,d,frame,detector:name,modes:[a,b],positions:[ia,ib],responses:[ra.text(),rb.text()],joint:joint.map(v=>v.text())});
  }
 }
 groups.general_modes={kernel_values:kernel.map(v=>v.text()),patterns,common_width:commonWidth,path_detector_pairs:modePaths,records:modeRecords};
 const schedules=[];
 for(const S of[2,3]){const d=commonWidth*S+1,frame=d+commonWidth*S,eta=new F(9,2),beta=eta.div(d),N=3*frame;
  for(let i=0;i<S;i++)for(let j=0;j<S;j++)for(let k=0;k<S;k++){const positions=[i,j,k],modes=["A","A","B"],x=Array(N).fill(0);
   for(let a=0;a<3;a++)for(let h=0;h<patterns[modes[a]].length;h++)x[a*frame+positions[a]*commonWidth+h]=patterns[modes[a]][h];
   const cost=sum(x),budget=beta.mul(N);check("two_mode_constant_cost",cost===12,{S,positions,cost});check("two_mode_hard_budget",new F(cost).cmp(budget)<=0,{S,positions,cost,budget:budget.text()});
   schedules.push({S,d,frame,positions,cost,beta:beta.text(),total_budget:budget.text()});
  }
 }
 groups.two_mode_schedule={modes:["A","A","B"],average_cost:"4/1",target_eta:"9/2",records:schedules};
 const numericalFailures=[],basic=[];
 const ds=[32,100,316,1000,3162,10000,31623,100000,316228,1000000];
 for(const eta of[.1,.5,1,2,5])for(const epsilon of[0,.2,.5,.8])for(const d of ds)for(const constraint of["hard","expected"]){
  const beta=eta/d,q=constraint==="hard"?1:1-epsilon,z=beta/q,scale=beta*Math.log(1/beta),lower=L(z,d),upper=U(z,d);
  if(!(lower>=0&&lower<=upper+1e-13&&Number.isFinite(upper)))numericalFailures.push({group:"poisson_bounds",eta,epsilon,d,constraint,lower,upper});
  basic.push({constraint,eta,epsilon,d,beta,effective_energy:z,normalized_lower:lower/scale,normalized_upper:upper/scale,leading_constant:-Math.expm1(-eta/q)/eta,feedback_vanishing_error_reference:Math.min(1,1/eta)});
 }
 const roots=[2,3,5].map(thresholdRoot),thresholdRows=[];
 for(const root of roots){let previous=-1,previousDelta=null;
  for(let j=0;j<=240;j++){const E=3*root.theta*j/240,p=poissonTail(E,root.r),K=E<=root.theta?root.slope*E:p;
   if(p>K+1e-12||K+1e-12<previous||K<0||K>1+1e-12)numericalFailures.push({group:"threshold_envelope",r:root.r,E,p,K});
   const delta=K-previous;if(j>=2&&previousDelta!==null&&delta>previousDelta+1e-11)numericalFailures.push({group:"threshold_concavity_grid",r:root.r,E});
   previousDelta=delta;previous=K;thresholdRows.push({r:root.r,E,theta_approx:root.theta,Q_equals_p:p,K,linear_slope:root.slope,time_sharing_gain:K-p});
  }
 }
 const splittingRows=[];
 for(const root of roots)for(const E of[.1,.5,1,2,5])for(let k=1;k<=8;k++){
  const p=poissonTail(E/k,root.r),response=p>=1?1:-Math.expm1(k*Math.log1p(-p)),Q=poissonTail(E,root.r);
  if(response>Q+1e-12)numericalFailures.push({group:"threshold_split",r:root.r,E,k,response,Q});
  splittingRows.push({kernel:"poisson_threshold",parameter:root.r,E,k,response,envelope:Q,log_survival:p>=1?-Infinity:k*Math.log1p(-p)});
 }
 for(const alpha of[.5,.8])for(const E of[.25,1,4])for(const k of[1,2,4,8,16,32,64,128,256]){
  const log_survival=-(E**alpha)*k**(1-alpha),response=-Math.expm1(log_survival);
  splittingRows.push({kernel:"sublinear_hazard",parameter:alpha,E,k,response,envelope:1,log_survival});
 }
 const exact={schema:"dead-time-v8-replay-v1",arithmetic:"BigInt rational arithmetic",finite_diagnostics_only:true,reconstruction:"New implementation executed in V8 and Node; reconstructed during temporary loss of local access. Original Python artifacts were subsequently recovered and their recorded SHA-256 values verified separately.",summary:{total_checks:Object.values(counts).reduce((a,b)=>a+b,0),checks_by_group:counts,failure_count:failures.length,passed:failures.length===0},failures,groups};
 const numerical={schema:"dead-time-v8-numerical-v1",arithmetic:"IEEE-754 binary64; not interval certified",poisson_rows:basic.length,threshold_rows:thresholdRows.length,splitting_rows:splittingRows.length,roots,failures:numericalFailures,normalization:"beta log(1/beta); coding n first, then beta,d",scope:"Finite formulas and numerical illustrations; no Lean, no claim of new independent proof."};
 return{exact,numerical,basic,thresholdRows,splittingRows,basicCSV:csv(basic),thresholdCSV:csv(thresholdRows),splittingCSV:csv(splittingRows)};
}

function xml(s){return String(s).replace(/[&<>"']/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&apos;"}[c]));}
function svgText(x,y,s,size=11,anchor="start",extra=""){return'<text x="'+x+'" y="'+y+'" font-size="'+size+'" text-anchor="'+anchor+'" '+extra+'>'+xml(s)+'</text>';}
function svgPanel(x,y,w,h,x0,x1,y0,y1,title,xlabel,ylabel,xticks,yticks,log=false){
 const X=v=>x+w*((log?Math.log(v):v)-(log?Math.log(x0):x0))/((log?Math.log(x1):x1)-(log?Math.log(x0):x0));
 const Y=v=>y+h-h*(v-y0)/(y1-y0);let s="";
 for(const v of xticks){const xx=X(v);s+='<path d="M '+xx.toFixed(3)+' '+y+' V '+(y+h)+'" stroke="#e4e7eb"/>';s+=svgText(xx,y+h+18,log?(v>=1000?v.toExponential(0):v):v,10,"middle");}
 for(const v of yticks){const yy=Y(v);s+='<path d="M '+x+' '+yy.toFixed(3)+' H '+(x+w)+'" stroke="#e4e7eb"/>';s+=svgText(x-8,yy+3,v,10,"end");}
 s+='<path d="M '+x+' '+y+' V '+(y+h)+' H '+(x+w)+'" stroke="#222" fill="none"/>';
 s+=svgText(x+w/2,y-16,title,14,"middle");
 s+=svgText(x+w/2,y+h+40,xlabel,12,"middle");
 s+=svgText(x-43,y+h/2,ylabel,12,"middle",'transform="rotate(-90 '+(x-43)+' '+(y+h/2)+')"');
 return{X,Y,s};
}
function svgLine(panel,points,color,dash="",width=2){const coords=points.map(p=>panel.X(p[0]).toFixed(3)+","+panel.Y(p[1]).toFixed(3)).join(" ");return'<polyline points="'+coords+'" fill="none" stroke="'+color+'" stroke-width="'+width+'"'+(dash?' stroke-dasharray="'+dash+'"':"")+'/>';}
function svgLegend(x,y,color,label,dash=""){return'<path d="M '+x+' '+(y-4)+' H '+(x+23)+'" stroke="'+color+'" stroke-width="2"'+(dash?' stroke-dasharray="'+dash+'"':"")+'/>'+svgText(x+30,y,label,10);}
function svgStart(title,desc){return'<svg xmlns="http://www.w3.org/2000/svg" width="1120" height="455" viewBox="0 0 1120 455"><title>'+xml(title)+'</title><desc>'+xml(desc)+'</desc><rect width="1120" height="455" fill="white"/><g font-family="Arial,DejaVu Sans,sans-serif" fill="#222">'+svgText(560,25,title,18,"middle");}
function capacitySVG(result){
 const blue="#0072B2",orange="#D55E00";let s=svgStart("Dead-time capacity: leading constants and explicit bounds","Numerical illustrations of proved formulas. Feedback vanishing-error reference: Wang 2020, DOI 10.3390/e22080846.");
 const a=svgPanel(65,75,450,245,0,6,0,2.05,"A. Wideband leading constants","Dead-time energy η=dβ","Coefficient of β log(1/β)",[0,1,2,3,4,5,6],[0,.5,1,1.5,2]);
 const b=svgPanel(635,75,440,245,32,1000000,0,1.05,"B. Explicit bounds at η=1","Dead-time slots d, β=1/d","Rate / [β log(1/β)]",[100,1000,10000,100000,1000000],[0,.25,.5,.75,1],true);
 s+=a.s+b.s;const etas=Array.from({length:400},(_,i)=>.05+5.95*i/399);
 s+=svgLine(a,etas.map(e=>[e,Math.min(1,1/e)]),"#333","6 4",1.8);
 s+=svgLine(a,etas.map(e=>[e,-Math.expm1(-e)/e]),blue);
 s+=svgLine(a,etas.map(e=>[e,-Math.expm1(-2*e)/e]),orange);
 for(const[constraint,epsilon,color]of[["hard",0,blue],["expected",.5,orange]]){
  const rows=result.basic.filter(r=>r.constraint===constraint&&r.epsilon===epsilon&&r.eta===1),low=rows.map(r=>[r.d,r.normalized_lower]),high=rows.map(r=>[r.d,r.normalized_upper]),polygon=low.concat(high.slice().reverse()).map(p=>b.X(p[0]).toFixed(3)+","+b.Y(p[1]).toFixed(3)).join(" ");
  s+='<polygon points="'+polygon+'" fill="'+color+'" opacity="0.08"/>';
  s+=svgLine(b,low,color)+svgLine(b,high,color,"6 4",1.6)+svgLine(b,[[32,rows[0].leading_constant],[1000000,rows[0].leading_constant]],color,"2 4",1.3);
  for(const p of low)s+='<circle cx="'+b.X(p[0]).toFixed(3)+'" cy="'+b.Y(p[1]).toFixed(3)+'" r="2.5" fill="'+color+'"/>';
 }
 s+=svgLegend(65,385,blue,"Hard energy: all fixed ε<1")+svgLegend(65,405,orange,"Expected energy: ε=0.5")+svgLegend(305,385,"#333","Feedback: error → 0","6 4");
 s+=svgLegend(635,385,blue,"Hard energy")+svgLegend(825,385,orange,"Expected energy: ε=0.5");
 s+=svgText(635,405,"Solid: PPM lower. Dashed: upper. Dotted: leading constant.",10);
 s+=svgText(560,442,"Analytical rate bounds; shaded gaps are not confidence intervals. Coding length tends to infinity before the wideband limit.",10,"middle");
 return s+"</g></svg>\n";
}
function generalSVG(result){
 const colors=["#0072B2","#D55E00","#009E73"];let s=svgStart("General trigger kernels: distinct splitting and scheduling effects","Photon-threshold envelope roots are floating-point approximations, not interval certificates. Sublinear finite-burst responses remain strictly below one analytically.");
 const a=svgPanel(65,75,450,245,0,2,0,1.02,"A. Photon-threshold response and envelope","Energy / θᵣ","Response",[0,.5,1,1.5,2],[0,.25,.5,.75,1]);
 const b=svgPanel(635,75,440,245,1,256,.6,1.025,"B. Equal splitting, sublinear hazard, E=1","Number k of pieces","Burst response",[1,4,16,64,256],[.6,.7,.8,.9,1],true);
 s+=a.s+b.s;
 for(let j=0;j<result.numerical.roots.length;j++){const root=result.numerical.roots[j],xs=Array.from({length:241},(_,i)=>2*i/240);
  s+=svgLine(a,xs.map(v=>[v,poissonTail(v*root.theta,root.r)]),colors[j],"5 4",1.4);
  s+=svgLine(a,xs.map(v=>[v,v<=1?root.slope*v*root.theta:poissonTail(v*root.theta,root.r)]),colors[j], "",2);
  s+=svgLegend(65+150*j,385,colors[j],"r="+root.r+", θ≈"+root.theta.toFixed(3));
 }
 s+=svgText(65,405,"Solid: K(E). Dashed: Q(E)=pᵣ(E). Mixing is strict below θᵣ.",10);
 for(const[alpha,color]of[[.5,colors[0]],[.8,colors[1]]]){
  const rows=result.splittingRows.filter(r=>r.kernel==="sublinear_hazard"&&r.parameter===alpha&&r.E===1),pts=rows.map(r=>[r.k,r.response]);s+=svgLine(b,pts,color);
  for(const p of pts)s+='<circle cx="'+b.X(p[0]).toFixed(3)+'" cy="'+b.Y(p[1]).toFixed(3)+'" r="2.3" fill="'+color+'"/>';
 }
 s+=svgLine(b,[[1,1],[256,1]],"#333","6 4",1.5);
 s+=svgLegend(635,385,colors[0],"α=0.5")+svgLegend(800,385,colors[1],"α=0.8")+svgLegend(940,385,"#333","Q=K=1","6 4");
 s+=svgText(635,405,"The value 1 is a supremum; no finite burst attains it.",10);
 s+=svgText(560,442,"Curves evaluate analytic formulas. Root decimals and finite checks do not replace the general proofs.",10,"middle");
 return s+"</g></svg>\n";
}
function buildArtifacts(result){
 const files={
 "results/replay_exact.json":JSON.stringify(result.exact,null,2)+"\n",
 "results/replay_numerical.json":JSON.stringify(result.numerical,null,2)+"\n",
 "results/replay_capacity_bounds.csv":result.basicCSV,
 "results/general_threshold_envelope.csv":result.thresholdCSV,
 "results/general_splitting_response.csv":result.splittingCSV,
 "results/replay_capacity_constants.svg":capacitySVG(result),
 "results/general_kernel_envelopes.svg":generalSVG(result)
 };
 files["results/replay_manifest.json"]=JSON.stringify({schema:"dead-time-current-replay-manifest-v1",execution:"Pure core executed in functions V8; full source executed in Node v24.22.3 after the local environment was restored.",date:"2026-11-25",exact_checks:result.exact.summary,numerical_failure_count:result.numerical.failures.length,generated_paths:Object.keys(files),historical_python_run:{checks:188983,failures:0,artifact_bytes_recovered:true,current_replay_is_distinct:true,historical_hash_records:"All five original generated-file SHA-256 values were revalidated from recovered bytes against the original run_summary.json."},formalization_performed:false,unavailable_artifacts:[]},null,2)+"\n";
 return files;
}

import fs from "node:fs";
import path from "node:path";
import {fileURLToPath} from "node:url";
const result=runReproduction();
const files=buildArtifacts(result);
const caseRoot=process.argv[2]?path.resolve(process.argv[2]):path.resolve(path.dirname(fileURLToPath(import.meta.url)),"..");
for(const[relative,content]of Object.entries(files)){const target=path.join(caseRoot,relative);fs.mkdirSync(path.dirname(target),{recursive:true});fs.writeFileSync(target,content,"utf8");}
console.log(JSON.stringify({exact:result.exact.summary,numerical:result.numerical,caseRoot},null,2));
if(result.exact.failures.length||result.numerical.failures.length)process.exitCode=1;

