// Exact bounded search in output-local-and-permutation cosets (complete graph).
// Source heuristic: Jorgensen arXiv:2609.16208, Theorem 6.3.
// A completed exhaustive failure is a finite computational result; a budget
// interruption is explicitly not a lower-bound certificate.
#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <iostream>
#include <unordered_set>
#include <vector>
using namespace std;
static constexpr int K=5;
using State=array<uint16_t,2*K>;
struct Hash {size_t operator()(const State&s)const {uint64_t h=0xcbf29ce484222325ULL;for(auto x:s){h^=x;h*=0x100000001b3ULL;}return h;}};
State canonical(State s){
 array<pair<uint16_t,uint16_t>,K> ps;
 for(int i=0;i<K;i++){array<uint16_t,3>a={s[2*i],s[2*i+1],uint16_t(s[2*i]^s[2*i+1])};sort(a.begin(),a.end());ps[i]={a[0],a[1]};}
 sort(ps.begin(),ps.end());for(int i=0;i<K;i++){s[2*i]=ps[i].first;s[2*i+1]=ps[i].second;}return s;
}
State move_state(State s,unsigned p){unsigned w=0;for(int i=0;i<K;i++){if(p&(2u<<(2*i)))w^=s[2*i];if(p&(1u<<(2*i)))w^=s[2*i+1];}for(int i=0;i<2*K;i++)if(p&(1u<<i))s[i]^=w;return canonical(s);}
int rank_matrix(array<unsigned,K>a){int rank=0;for(int bit=K-1;bit>=0;bit--){int p=rank;while(p<K&&!(a[p]&(1u<<bit)))p++;if(p==K)continue;swap(a[p],a[rank]);for(int i=0;i<K;i++)if(i!=rank&&(a[i]&(1u<<bit)))a[i]^=a[rank];rank++;}return rank;}
int heuristic(const State&s){
 array<int,2*K> parent;for(int i=0;i<2*K;i++)parent[i]=i;
 auto find=[&](int i){while(parent[i]!=i){parent[i]=parent[parent[i]];i=parent[i];}return i;};
 array<unsigned,K>d{};
 for(int i=0;i<K;i++)for(int j=0;j<K;j++){unsigned a=(s[2*i]>>(2*j))&3,b=(s[2*i+1]>>(2*j))&3;
  if(a||b){int x=find(i),y=find(K+j);parent[x]=y;}
  if(a&&b&&a!=b)d[i]|=1u<<j;
 }
 int components=0;for(int i=0;i<2*K;i++)if(find(i)==i)components++;
 return 2*K-components-rank_matrix(d);
}
vector<unsigned>gens,path;
array<unordered_set<State,Hash>,12>failed;
uint64_t visited=0,limit=0;bool interrupted=false;
bool dfs(const State&s,int remaining){
 if(++visited>limit){interrupted=true;return false;}
 int h=heuristic(s);if(h>remaining)return false;if(h==0)return true;
 if(remaining==0)return false;if(failed[remaining].count(s))return false;
 vector<pair<State,unsigned>> next;next.reserve(90);
 for(auto p:gens){State t=move_state(s,p);if(heuristic(t)<=remaining-1)next.push_back({t,p});}
 sort(next.begin(),next.end(),[](auto&a,auto&b){return a.first<b.first;});
 next.erase(unique(next.begin(),next.end(),[](auto&a,auto&b){return a.first==b.first;}),next.end());
 for(auto&entry:next){path.push_back(entry.second);if(dfs(entry.first,remaining-1))return true;path.pop_back();if(interrupted)return false;}
 failed[remaining].insert(s);return false;
}
int main(int argc,char**argv){
 int which=argc>1?atoi(argv[1]):1;int bound=argc>2?atoi(argv[2]):8;limit=argc>3?strtoull(argv[3],nullptr,10):10000000;
 State s;
 if(which==1)s={426,757,443,749,358,729,409,630,494,695};
 else {for(int i=0;i<2*K;i++)s[i]=1u<<i;unsigned x=0,z=0;for(int i=0;i<K;i++){x|=1u<<(2*i);z|=2u<<(2*i);}s=move_state(s,z);s=move_state(s,x);}
 // The second target must be formed without sorting between the two global
 // transvections, since sorting permutes output sites. Both global labels
 // are permutation-invariant, so the sort is harmless here, but local row
 // canonicalization is not. Rebuild the literal dual-axis matrix directly.
 if(which!=1){for(int i=0;i<K;i++){s[2*i]=0;s[2*i+1]=0;for(int j=0;j<K;j++){s[2*i]^=(3u<<(2*j));s[2*i+1]^=(1u<<(2*j));}s[2*i]^=1u<<(2*i);s[2*i+1]^=2u<<(2*i);}}
 s=canonical(s);
 for(int i=0;i<K;i++)for(int j=i+1;j<K;j++)for(unsigned a=1;a<=3;a++)for(unsigned b=1;b<=3;b++)gens.push_back((a<<(2*i))|(b<<(2*j)));
 auto started=chrono::steady_clock::now();bool found=dfs(s,bound);double elapsed=chrono::duration<double>(chrono::steady_clock::now()-started).count();
 cout<<"{\"target_class\":\""<<(which==1?"exceptional_k5":"dual_axis")<<"\",\"bound\":"<<bound<<",\"initial_heuristic\":"<<heuristic(s)<<",\"visited\":"<<visited<<",\"interrupted\":"<<(interrupted?"true":"false")<<",\"found\":"<<(found?"true":"false")<<",\"exhaustive_failure\":"<<(!found&&!interrupted?"true":"false")<<",\"elapsed_seconds\":"<<elapsed<<",\"failed_states_by_remaining\":[";
 for(int i=0;i<=bound;i++){if(i)cout<<",";cout<<failed[i].size();}cout<<"],\"quotient_path_pauli_masks\":[";for(unsigned i=0;i<path.size();i++){if(i)cout<<",";cout<<path[i];}cout<<"]}\n";
 return interrupted?2:0;
}
