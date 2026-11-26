#include<bits/stdc++.h>
using namespace std;
using ull=uint64_t; using U=__uint128_t;
ull mul(ull a,ull b,ull n){return (U)a*b%n;}
ull powm(ull a,ull e,ull n){ull r=1;for(;e;e>>=1,a=mul(a,a,n))if(e&1)r=mul(r,a,n);return r;}
bool prime(ull n){if(n<2)return false;for(ull p:{2,3,5,7,11,13,17,19,23,29,31,37}){if(n%p==0)return n==p;}ull d=n-1,s=0;while(!(d&1))d>>=1,++s;
for(ull a:{2,3,5,7,11}){if(a>=n)continue;ull x=powm(a,d,n);if(x==1||x==n-1)continue;bool ok=false;for(ull j=1;j<s;j++){x=mul(x,x,n);if(x==n-1){ok=true;break;}}if(!ok)return false;}return true;}
ull rho(ull n){if(n%2==0)return 2;
for(ull c=1;;c++){auto f=[&](ull x){return (mul(x,x,n)+c)%n;};ull x=2,y=2,g=1;for(int step=0;step<40000&&g==1;step++){x=f(x);y=f(f(y));g=gcd(n,x>y?x-y:y-x);}if(1<g&&g<n)return g;}}
void fact(ull n,vector<ull>&f){if(n==1)return;for(ull p:{2,3,5,7,11,13,17,19,23,29,31})while(n%p==0){f.push_back(p);n/=p;}if(n==1)return;if(prime(n)){f.push_back(n);return;}ull p=rho(n);fact(p,f);fact(n/p,f);}
void gen(vector<pair<int,int>>&a,int i,ull val,vector<ull>&out){if(i==(int)a.size()){if(val>=4)out.push_back(val);return;}auto [p,e]=a[i];for(int j=0;j<=e;j++){gen(a,i+1,val,out);val*=p;}}
struct R{ull maxq=1,A=1,M=1,O=1;};
R stats(ull n){vector<ull>f;fact(n,f);sort(f.begin(),f.end());R r;for(int i=0;i<(int)f.size();){int j=i+1;while(j<(int)f.size()&&f[j]==f[i])j++;ull p=f[i];if(p>=7){r.maxq=max(r.maxq,p);for(int k=0;k<j-i;k++)r.M*=p;for(int k=0;k<(j-i+1)/2;k++)r.A*=p;if((j-i)&1)r.O*=p;} i=j;}return r;}
int main(int argc,char**argv){int sp[32021]={};for(int i=2;i<=32020;i++)if(!sp[i])for(int j=i;j<=32020;j+=i)if(!sp[j])sp[j]=i;vector<ull>u;
for(int d=6;d<=32020;d++){map<int,int>e{{2,2},{3,1},{5,1}};for(int q=d;q>1;q/=sp[q])e[sp[q]]+=2;vector<pair<int,int>>a(e.begin(),e.end());gen(a,0,1,u);}
sort(u.begin(),u.end());u.erase(unique(u.begin(),u.end()),u.end());cerr<<"divisor list "<<u.size()<<" max "<<u.back()+6<<"\n";
ull num=0,maxn=0,k=0;ull floor=argc>1?stoull(argv[1]):0;ofstream o("candidate_n.txt");for(auto z:u){ull N=z+5;if(N<floor)continue; int B=(N<10000 ?32020:min<ull>(32020,max<ull>(14110,(15000*N+N-5001)/(N-5000)+2015)));
if(z>60ull*B*B)continue;
if(N>1e6 && N>60ull*B*B+5)continue;
int maxnode = N>=1000000 ? 6400 : 7200;
R a=stats(N);if(a.maxq>maxnode)continue;R b=stats(N-1);if(b.maxq>maxnode)continue;R c=stats(N-2);if(c.maxq>maxnode)continue;
U SB=B;U B2=15*SB*SB/36+1,B3=20*SB*SB*SB/216+1;U Dmax=1;for(int j=0;j<6;j++)Dmax*=SB;
// Compare D*(6^6) strictly against S^6.
U D=(U)a.M*b.M*c.M;if(D*46656>Dmax)continue;
R d=stats(N-3);if(D*d.O*46656>Dmax)continue;D*=d.O;
R e=stats(N-4);if(D*e.O*46656>Dmax)continue;D*=e.O;
R f=stats(N-5);if(D*f.O*46656>Dmax)continue;
if((U)d.A*e.A*f.O>=B3 || (U)e.A*f.O>=B2)continue;
num++;maxn=N+1;o<<N+1<<'\n';}cerr<<"survivors "<<num<<" max "<<maxn<<"\n";
}
