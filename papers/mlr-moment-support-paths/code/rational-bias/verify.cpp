#include<bits/stdc++.h>
#include<gmpxx.h>
#include<omp.h>
using namespace std;using ll=long long;using I=mpz_class;
struct Tup{uint8_t a,b,s,t;};
vector<int> ns;
map<int,vector<vector<Tup>>> zlist;
vector<int> pp{79,83,89,97,101,103,107,109};
vector<pair<int,int>> req;
int smallp(int n,int a){return (n%a+a)%a;}
template<int P> void build(){
 vector<int>w;
 vector<int>used(P);
 for(size_t i=0;i<ns.size();++i)if(req[i].first==P||req[i].second==P)used[(ns[i]-1)%P]=1;
 for(int x=6;x<P;x++)if(used[x])w.push_back(x);
 if(w.empty())return;
 vector<int> head((size_t)P*P*P*P,-1);
 struct Entry{int next;int n;};
 vector<Entry> entries;entries.reserve((size_t)P*P*P*w.size());
 int fall[P][7],back[P][7],inv[P],half=(P+1)/2;
 auto md=[](int x){x%=P;return x<0?x+P:x;};
 for(int i=1;i<P;i++)for(int j=1;j<P;j++)if(i*j%P==1){inv[i]=j;break;}
 for(int n:w){fall[n][0]=1;for(int j=1;j<=6;j++)fall[n][j]=md(fall[n][j-1]*(n-j+1));
  for(int j=0;j<=6;j++)back[n][j]=md(fall[n][j]*inv[fall[n][6]]);}
 for(int v5=0;v5<P;v5++)for(int v4=0;v4<P;v4++)for(int v3=0;v3<P;v3++){
  size_t k=((size_t(v5)*P+v4)*P+v3)*P;
  for(int n:w){
   int a=md(v5*back[n][5]*half);
   int b=md((md(v4*back[n][4])-a*a)*half);
   int c=md((md(v3*back[n][3])-2*a*b)*half);
   int predicted=md(md(b*b+2*a*c)*inv[back[n][2]]);
   size_t pos=k+predicted;entries.push_back({head[pos],n});head[pos]=entries.size()-1;
  }
 }
 vector<vector<Tup>> out(P);
 for(int a=0;a<P;a++)for(int b=a;b<P;b++){
  int q[5]={1,0,0,0,0};int len=0;
  for(int r:{a,a+1,b,b+1}){++len;for(int j=len;j>=0;j--)q[j]=md((j?q[j-1]:0)+(j<len?q[j]*(j-r):0));}
  for(int s=0;s<P;s++)for(int t=s;t<P;t++){
   auto cj=[&](int j){return md((j<5?q[j]*(j*j-(s+t)*j+s*t):0)+(j>=1&&j<=5?q[j-1]*(2*j-1-s-t):0)+(j>=2&&j<=6?q[j-2]:0));};
   int c5=cj(5),c4=cj(4),c3=cj(3),c2=cj(2);
   int h=head[((size_t(c5)*P+c4)*P+c3)*P+c2];if(h==-1)continue;
   int c1=cj(1),c0=cj(0);
   for(int i=h;i!=-1;i=entries[i].next){
    int n=entries[i].n;
    int A=md(c5*back[n][5]*half);
    int B=md((md(c4*back[n][4])-A*A)*half);
    int C=md((md(c3*back[n][3])-2*A*B)*half);
    if(md(c1*back[n][1]-2*B*C)||md(c0*back[n][0]-C*C))continue;
    out[n].push_back(Tup{(uint8_t)a,(uint8_t)b,(uint8_t)s,(uint8_t)t});
   }
  }
 }
 size_t sum=0;for(auto &v:out)sum+=v.size();
 zlist[P]=move(out);
 cerr<<"Prime "<<P<<" residues "<<w.size()<<" total local tuples "<<sum<<"\n";
}
int md(int x,int p){x%=p;return x<0?x+p:x;}
bool good(int N,int p){return N%p>=6;}
vector<int> primes(int n){vector<int>a;for(int p=2;p*(ll)p<=n;p++)while(n%p==0){a.push_back(p);n/=p;}if(n>1)a.push_back(n);return a;}
int powm(int a,int b,int p){int r=1;for(;b;b>>=1,a=md(a*a,p))if(b&1)r=md(r*a,p);return r;}
bool modsquare(int a,int b,int s,int t,int n,int P){
 int q[7]={1},len=0;
 for(int r:{a,a+1,b,b+1,s,t}){r%=P;++len;for(int j=len;j>=0;j--)q[j]=md((j?q[j-1]:0)+(j<len?q[j]*(j-r):0),P);}
 int f[7];f[6]=1;int v=n%P, h=(P+1)/2;
 for(int j=5;j>=0;j--)f[j]=md(f[j+1]*powm(v-j,P-2,P),P);
 for(int j=0;j<6;j++)f[j]=md(f[j]*q[j],P);
 int A=md(f[5]*h,P),B=md((f[4]-A*A)*h,P),C=md((f[3]-2*A*B)*h,P);
 return !(md(f[0]-C*C,P)||md(f[1]-2*B*C,P)||md(f[2]-B*B-2*A*C,P));
}
bool exactsquare(int a,int b,int s,int t,int N,ostream & out){
 ll q[7]={1};int len=0;
 // Bound absolute intermediate coefficient sums by (6400+7)^6, may exceed int64.
 I Q[7];Q[0]=1;
 for(int r:{a,a+1,b,b+1,s,t}){++len;for(int j=len;j>=0;j--)Q[j]=(j?Q[j-1]:I(0))+(j<len?I(Q[j]*(j-r)):I(0));}
 I F[7];I falling=1;for(int j=0;j<=6;j++){F[j]=Q[j]*falling;falling*=N-j;}
 I L=F[6],U=4*L*F[4]-F[5]*F[5],V=8*L*L*F[3]-F[5]*U;
 if(64*L*L*L*F[2]-U*U-4*F[5]*V!=0) return false;
 if(64*L*L*L*L*F[1]-U*V!=0) return false;
 if(256*L*L*L*L*L*F[0]-V*V!=0) return false;
 out<<"EXACT SQUARE n="<<N+1<<" support starts/singletons "<<a<<" "<<b<<" "<<s<<" "<<t<<" cubic (desc) "<<16*L*L*L<<" "<<8*L*L*F[5]<<" "<<2*L*U<<" "<<V;
 return true;
}
int main(){
 ifstream in("candidate_n.txt");int n;while(in>>n)ns.push_back(n);
 if(ns.size()!=16668||ns.back()!=465130){cerr<<"Bad input "<<ns.size()<<"\n";return 3;}
 for(int n:ns){
  vector<int>g;for(int p:pp)if(good(n-1,p))g.push_back(p);
  if(g.size()<2)throw logic_error("No primes");
  req.push_back({g[0],g[1]});
 }
 build<79>();build<83>();build<89>();build<97>();build<101>();build<103>();build<107>();build<109>();
 vector<vector<int>> crtpp(pp.size()*pp.size());
 auto idx=[&](int p,int q){return (find(pp.begin(),pp.end(),p)-pp.begin())*pp.size()+(find(pp.begin(),pp.end(),q)-pp.begin());};
 for(auto [p,q]:req){auto& v=crtpp[idx(p,q)];if(!v.empty())continue;v.assign(p*q,0);for(int x=0;x<p*q;x++)v[x%p*q+x%q]=x;}
 vector<string> lines(ns.size());
 ll squares=0, survivors3=0, survivors4=0, crt_count=0, done=0;
 #pragma omp parallel for schedule(dynamic,1) reduction(+:squares,survivors3,survivors4,crt_count)
 for(int z=0;z<(int)ns.size();z++){
  int n=ns[z],N=n-1;auto [p,q]=req[z];const auto& v=crtpp[idx(p,q)];
  const auto& U=zlist.at(p)[N%p];const auto& V=zlist.at(q)[N%q];
  int T=min(N-1,6400);
  int u=N-5,B=N<10000?32020:min<ll>(32020,max<ll>(14110,(15000LL*N+N-5001)/(N-5000)+2015));
  int E=1; // independently compute minimal S-15 required by u | 60*(S-15)^2.
  vector<int> h=primes(u);
  for(int i=0;i<(int)h.size();){
   int j=i+1;while(j<(int)h.size()&&h[j]==h[i])j++;
   int cap=h[i]==2?2:(h[i]==3||h[i]==5?1:0);
   for(int k=0;k<(j-i-cap+1)/2;k++)E*=h[i];i=j;
  }
  int r3=7,r4=0;for(int p0:{7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73})if(good(N,p0)){if(r4==0)r4=p0;else{r3=p0;break;}}
  if(r4==0||!good(N,r3)||r3==r4)throw logic_error("low mod check");
  ll num=0,stage3=0,stage4=0;ostringstream out;
  for(const auto& x:U)for(const auto& y:V){
   for(int ip=0;ip<2;ip++){
    if(ip==1&&y.a==y.b)continue;
    int a=v[x.a*q+(ip?y.b:y.a)],b=v[x.b*q+(ip?y.a:y.b)];
    if(a<1||b<1||a>=T||b>=T||abs(a-b)<=1)continue;
    for(int is=0;is<2;is++){
     if(is==1&&y.s==y.t)continue;
     int s=v[x.s*q+(is?y.t:y.s)],t=v[x.t*q+(is?y.s:y.t)];
     if(s<1||s>T||t<1||t>T||s==t)continue;
     if(s==a||s==a+1||s==b||s==b+1||t==a||t==a+1||t==b||t==b+1)continue;
     // Sorting/tight run conditions omitted: harmless superset.
     int S=2*(a+b)+2+s+t;
     if(S>B||(S-15)%E)continue;
     num++;
     if(!modsquare(a,b,s,t,N,r4))continue;stage3++;
     if(!modsquare(a,b,s,t,N,r3))continue;stage4++;
     if(exactsquare(a,b,s,t,N,out)){squares++;out<<"\n";}
    }
   }
  }
  crt_count+=num;survivors3+=stage3;survivors4+=stage4;
  out<<"DONE "<<n<<" "<<p<<" "<<q<<" "<<U.size()<<" "<<V.size()<<" "<<num<<" "<<stage3<<" "<<stage4<<"\n";
  lines[z]=out.str();
  #pragma omp critical
  {done++;if(done%100==0)cerr<<"Checked "<<done<<"/"<<ns.size()<<"\n";}
 }
 ofstream o("verification.txt");for(auto &x:lines)o<<x;
 cerr<<"CLOSURE DONE n="<<ns.size()<<" crt="<<crt_count<<" mod3="<<survivors3<<" mod4="<<survivors4<<" squares="<<squares<<"\n";
 return squares?4:0;
}
