// Run with: node verify_exact.js
function gcd(a, b) {
  if (a < 0n) a = -a;
  while (b) [a, b] = [b, a % b];
  return a;
}

function q(a, b = 1n) {
  a = BigInt(a);
  b = BigInt(b);
  if (b <= 0n) throw Error("Expected a positive denominator");
  const g = gcd(a, b);
  return [a / g, b / g];
}

const zero = q(0);
const one = q(1);
const two = q(2);
const add = ([a, b], [c, d]) => q(a * d + c * b, b * d);
const sub = ([a, b], [c, d]) => q(a * d - c * b, b * d);
const mul = ([a, b], [c, d]) => q(a * c, b * d);
const div = ([a, b], [c, d]) => q(a * d, b * c);
const cmp = ([a, b], [c, d]) => a * d - c * b;
const abs = ([a, b]) => q(a < 0n ? -a : a, b);
const product = xs => xs.reduce(mul, one);
const sum = xs => xs.reduce(add, zero);
const positive = x => cmp(x, zero) > 0n;
const fractionText = a => a.join("/");
const max = (a, b) => cmp(a, b) > 0n ? a : b;

function check(pass, label) {
  if (!pass) throw Error(label);
}

function cOf(messages) {
  const h=Math.ceil(messages/2);
  return q(h-2,2*(2*h-1));
}

function correction(c,s) {
  let value=div(mul(q(3),c),add(one,mul(two,c)));
  for(let j=1;j<=s;j++) {
    const a=mul(q(3*j),c);
    value=cmp(a,one)<=0n ? div(mul(mul(q(3),c),sub(one,a)), add(one,mul(two,c)))
                         : mul(value,sub(one,div(one,a)));
  }
  return value;
}

function frontier(messages,s) {
  if(messages===2) return zero;
  const c=cOf(messages);
  return div(add(one,mul(q(3),c)),add(q(3*(s+1)),correction(c,s)));
}

function timing(messages,s) {
  const c=cOf(messages);
  if(cmp(c,q(1,3*s))<=0n) return div(one,add(one,mul(q(s),sub(one,c))));
  const delta=sub(frontier(messages,s-1),q(1,3*s));
  return div(delta,add(c,delta));
}

function binom(n,k) {
  if(k>n) return 0n;
  let result=1n;
  for(let i=1;i<=k;i++) result=result*BigInt(n-i+1)/BigInt(i);
  return result;
}

function unanimity(n,k) {
  return q(binom(Math.floor(n/2),k)+binom(Math.ceil(n/2),k),binom(n,k));
}

function main() {
  let timingChecks=0, envelopes=0, feasibleBranches=0, probabilityBounds=0;
  const table=new Map();
  for(let m=2;m<=32;m++) {
    for(let s=0;s<=28;s++) table.set(m+","+s,frontier(m,s));
    for(let k=2;k<=m;k++) {
      check(cmp(unanimity(m,k),q(1,2n**BigInt(k-1)))<=0n,"unanimity tail");
      probabilityBounds++;
    }
  }
  for(let m=3;m<=32;m++) {
    for(let s=1;s<=28;s++) {
      const t=timing(m,s);
      const next=sub(one,t);
      const remainderLower=mul(q(s,s+1),sub(one,q(1,3*s*s)));
      check(cmp(t,q(5,7*(s+1)))>=0n && cmp(t,q(1,s))<=0n &&
            cmp(next,remainderLower)>=0n, "uniform block fraction");
      timingChecks++;
      let envelope=zero;
      for(let k=2;k<=m;k++) {
        envelope=max(envelope,add(mul(t,unanimity(m,k)),mul(next,table.get(k+","+(s-1)))));
      }
      check(cmp(envelope,table.get(m+","+s))===0n,"archived envelope");
      envelopes++;
    }
  }
  for(const r of [1,2,8,16,24,28]) {
    for (let drop=0;drop<=3;drop++) {
      const L=1000007n;
      let length=L, m=32;
      for(let s=r;s>=1;s--) {
        check(3n*BigInt(r+1)*length>=L*BigInt(s+1),"remaining length");
        const t=timing(m,s);
        const first=length*t[0]/t[1];
        check((first+1n)*21n*BigInt(r+1)>=5n*L,"integer first block");
        length-=first;
        m=Math.max(3,m-drop);
      }
      check(3n*BigInt(r+1)*length>=L,"terminal block");
      feasibleBranches++;
    }
  }
  return {exact_timing_checks:timingChecks, archived_envelope_checks:envelopes,
    unanimity_bound_checks:probabilityBounds, integer_branch_checks:feasibleBranches,
    scope:"Exact finite rational checks. Length and coding proofs are in the manuscript."};
}

console.log(JSON.stringify(main(), null, 2));
