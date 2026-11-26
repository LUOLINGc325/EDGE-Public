// Path-only bounded reverse search. No intermediate output permutations.
// Canonicalizing input columns by local frames/permutations is a right action:
// it commutes with every physical path generator and preserves the terminal
// local-permutation goal. Output canonicalization is local on each wire only.
// Exhaustive_failure is true only if every target placement finishes normally.
#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <iostream>
#include <set>
#include <tuple>
#include <unordered_set>
#include <vector>
using namespace std;
#ifndef TARGET_K
#define TARGET_K 5
#endif
constexpr int K=TARGET_K;
static_assert(K>=3 && K<=7,"row masks and search support 3<=K<=7");
using State=array<uint16_t,2*K>;
struct Hash {size_t operator()(const State&s) const {uint64_t h=1469598103934665603ULL;for(auto x:s){h^=x;h*=1099511628211ULL;}return h;}};
void rowcanon(State&s){for(int i=0;i<K;i++){array<uint16_t,3>a={s[2*i],s[2*i+1],uint16_t(s[2*i]^s[2*i+1])};sort(a.begin(),a.end());s[2*i]=a[0];s[2*i+1]=a[1];}}
void colcanon(State&s){
 array<pair<uint16_t,uint16_t>,K> ps;
 for(int j=0;j<K;j++){uint16_t a=0,b=0;for(int i=0;i<2*K;i++){a|=((s[i]>>(2*j))&1)<<i;b|=((s[i]>>(2*j+1))&1)<<i;}array<uint16_t,3>t={a,b,uint16_t(a^b)};sort(t.begin(),t.end());ps[j]={t[0],t[1]};}
 sort(ps.begin(),ps.end());s.fill(0);
 for(int j=0;j<K;j++)for(int i=0;i<2*K;i++){s[i]|=((ps[j].first>>i)&1)<<(2*j);s[i]|=((ps[j].second>>i)&1)<<(2*j+1);}
}
State canonical(State s){
 // Two fixed passes suffice for a sound (not necessarily complete) reduction.
 // There is no need to claim a canonical representative for the whole orbit.
 rowcanon(s);colcanon(s);rowcanon(s);colcanon(s);rowcanon(s);
 return s;
}
State move_state(State s,unsigned p){unsigned v=0;for(int i=0;i<K;i++){if(p&(2u<<(2*i)))v^=s[2*i];if(p&(1u<<(2*i)))v^=s[2*i+1];}for(int i=0;i<2*K;i++)if(p&(1u<<i))s[i]^=v;return canonical(s);}
int rank_matrix(array<unsigned,K>a){int r=0;for(int b=K-1;b>=0;b--){int j=r;while(j<K&&!(a[j]&(1u<<b)))j++;if(j==K)continue;swap(a[r],a[j]);for(int i=r+1;i<K;i++)if(a[i]&(1u<<b))a[i]^=a[r];r++;}return r;}
int path_rank_bound(const State&s){
 // Minimize sum of cut ranks over ALL terminal input-to-output assignments.
 // A DP over subsets enforces nested prefix assignments. For each fixed
 // assignment, one adjacent CNOT changes only its own cut rank, by at most 1.
 array<int,1<<K>dp;dp.fill(100);dp[0]=0;
 for(unsigned mask=1;mask<(1u<<K);mask++){
  int count=__builtin_popcount(mask),best=100;
  for(int j=0;j<K;j++)if(mask&(1u<<j))best=min(best,dp[mask^(1u<<j)]);
  if(count==K){dp[mask]=best;continue;}
  unsigned keep=0;for(int j=0;j<K;j++)if(!(mask&(1u<<j)))keep|=3u<<(2*j);
  array<unsigned,2*K>a{};for(int i=0;i<2*count;i++)a[i]=s[i]&keep;
  int rank=0;for(int b=2*K-1;b>=0;b--){int j=rank;while(j<2*count&&!(a[j]&(1u<<b)))j++;if(j==2*count)continue;swap(a[rank],a[j]);for(int i=rank+1;i<2*count;i++)if(a[i]&(1u<<b))a[i]^=a[rank];rank++;}
  dp[mask]=best+rank;
 }
 return dp[(1<<K)-1];
}
int heuristic(const State&s){
#ifdef NO_LMC
 return path_rank_bound(s);
#else
 array<int,2*K>p;for(int i=0;i<2*K;i++)p[i]=i;
 auto find=[&](int i){while(p[i]!=i){p[i]=p[p[i]];i=p[i];}return i;};
 array<unsigned,K>d{};
 for(int i=0;i<K;i++)for(int j=0;j<K;j++){unsigned a=(s[2*i]>>(2*j))&3,b=(s[2*i+1]>>(2*j))&3;if(a||b){int x=find(i),y=find(K+j);p[x]=y;}if(a&&b&&a!=b)d[i]|=1u<<j;}
 int comps=0;for(int i=0;i<2*K;i++)if(find(i)==i)comps++;
 return max(2*K-comps-rank_matrix(d),path_rank_bound(s));
#endif
}
vector<unsigned>gens,path;
array<unordered_set<State,Hash>,25>failed;
uint64_t visited=0,limit=0;bool interrupted=false;
bool dfs(const State&s,int remaining){
 if(++visited>limit){interrupted=true;return false;}
 int h=heuristic(s);if(h>remaining)return false;if(h==0)return true;if(remaining==0)return false;
 if(failed[remaining].count(s))return false;
 vector<tuple<int,State,unsigned>>next;next.reserve(gens.size());
 for(auto g:gens){State t=move_state(s,g);int th=heuristic(t);if(th<=remaining-1)next.push_back({th,t,g});}
 sort(next.begin(),next.end());
 next.erase(unique(next.begin(),next.end(),[](auto&a,auto&b){return get<1>(a)==get<1>(b);}),next.end());
 for(auto &n:next){path.push_back(get<2>(n));if(dfs(get<1>(n),remaining-1))return true;path.pop_back();if(interrupted)return false;}
 failed[remaining].insert(s);return false;
}
State target(bool exceptional){State s{};if(exceptional){array<uint16_t,10>old={426,757,443,749,358,729,409,630,494,695};for(int i=0;i<min(10,2*K);i++)s[i]=old[i];}else{for(int i=0;i<K;i++){for(int j=0;j<K;j++){s[2*i]^=(K%2?3u:2u)<<(2*j);s[2*i+1]^=1u<<(2*j);}s[2*i]^=1u<<(2*i);s[2*i+1]^=2u<<(2*i);}}return s;}
int main(int argc,char**argv){
 bool exceptional=argc>1?atoi(argv[1]):0;int bound=argc>2?atoi(argv[2]):11;limit=argc>3?strtoull(argv[3],nullptr,10):1000000;
 if(bound<0||bound>=25||exceptional&&K!=5){cerr<<"invalid bound or exceptional size\n";return 3;}
 for(int i=0;i<K-1;i++)for(unsigned a=1;a<=3;a++)for(unsigned b=1;b<=3;b++)gens.push_back((a<<(2*i))|(b<<(2*(i+1))));
 State base=target(exceptional);array<int,K>perm{};for(int i=0;i<K;i++)perm[i]=i;set<State>starts;
 if(!exceptional && K!=5)starts.insert(canonical(base));
 else do{State s;for(int i=0;i<K;i++){s[2*i]=base[2*perm[i]];s[2*i+1]=base[2*perm[i]+1];}starts.insert(canonical(s));}while(next_permutation(perm.begin(),perm.end()));
 auto started=chrono::steady_clock::now();bool found=false;size_t done=0;State found_start{};
 for(auto&s:starts){if(dfs(s,bound)){found=true;found_start=s;break;}if(interrupted)break;done++;cerr<<"finished target placement "<<done<<"/"<<starts.size()<<" visited "<<visited<<"\n";}
 double elapsed=chrono::duration<double>(chrono::steady_clock::now()-started).count();
 cout<<"{\"k\":"<<K<<",\"target_class\":\""<<(exceptional?"exceptional_k5":"dual_axis")<<"\",\"bound\":"<<bound<<",\"target_representatives\":"<<starts.size()<<",\"completed_representatives\":"<<done<<",\"visited\":"<<visited<<",\"interrupted\":"<<(interrupted?"true":"false")<<",\"found\":"<<(found?"true":"false")<<",\"exhaustive_failure\":"<<(!found&&!interrupted?"true":"false")<<",\"elapsed_seconds\":"<<elapsed<<",\"failed_states_by_remaining\":[";
 for(int i=0;i<=bound;i++){if(i)cout<<",";cout<<failed[i].size();}cout<<"],\"canonical_start\":[";for(int i=0;i<2*K;i++){if(i)cout<<",";cout<<found_start[i];}cout<<"],\"quotient_path_pauli_masks\":[";for(unsigned i=0;i<path.size();i++){if(i)cout<<",";cout<<path[i];}cout<<"]}\n";
 return interrupted?2:0;
}
