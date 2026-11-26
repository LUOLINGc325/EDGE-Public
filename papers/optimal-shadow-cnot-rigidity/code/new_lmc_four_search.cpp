// Exact bounded search in output-local-and-permutation cosets (complete graph).
// Source heuristic: Jorgensen arXiv:2609.16208, Theorem 6.2;
// enumerate all 24 output permutations to minimize its determinant/diagonal terms.
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
static constexpr int K=4;
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

 int minmiddle=K,mindiag=K;
 array<int,K> perm;for(int i=0;i<K;i++)perm[i]=i;
 auto rowmiddle=[](array<unsigned,K> q){
  int empty=0,duplicates=0;array<int,1<<K> counts{};
  for(auto row:q){if(!row)empty++;else counts[row]++;}
  for(auto count:counts)duplicates+=count/2;
  return (2*K-2*empty-duplicates+2)/3;
 };
 do {
  array<unsigned,K> q{},qt{};int deficiency=0;
  for(int i=0;i<K;i++){
   q[i]=d[perm[i]]^(1u<<i);
   unsigned a=(s[2*perm[i]]>>(2*i))&3,b=(s[2*perm[i]+1]>>(2*i))&3;
   int blockrank=(a||b)+(a&&b&&a!=b);deficiency+=2-blockrank;
  }
  for(int i=0;i<K;i++)for(int j=0;j<K;j++)if(q[i]&(1u<<j))qt[j]|=1u<<i;
  int md=max(rank_matrix(q),max(rowmiddle(q),rowmiddle(qt)));
  minmiddle=min(minmiddle,md);mindiag=min(mindiag,(deficiency+1)/2);
 }while(next_permutation(perm.begin(),perm.end()));
 return K-components+max(minmiddle,mindiag);
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
 int which=argc>1?atoi(argv[1]):1;int bound=argc>2?atoi(argv[2]):5;limit=argc>3?strtoull(argv[3],nullptr,10):10000000;
 State s;
 if(which==1)s={87,171,93,174,117,186,213,234};
 else s={87,191,173,223,185,247,214,253};
 s=canonical(s);
 for(int i=0;i<K;i++)for(int j=i+1;j<K;j++)for(unsigned a=1;a<=3;a++)for(unsigned b=1;b<=3;b++)gens.push_back((a<<(2*i))|(b<<(2*j)));
 auto started=chrono::steady_clock::now();bool found=dfs(s,bound);double elapsed=chrono::duration<double>(chrono::steady_clock::now()-started).count();
 cout<<"{\"target_class\":\""<<(which==1?"k4_first":"k4_second")<<"\",\"bound\":"<<bound<<",\"initial_heuristic\":"<<heuristic(s)<<",\"visited\":"<<visited<<",\"interrupted\":"<<(interrupted?"true":"false")<<",\"found\":"<<(found?"true":"false")<<",\"exhaustive_failure\":"<<(!found&&!interrupted?"true":"false")<<",\"elapsed_seconds\":"<<elapsed<<",\"failed_states_by_remaining\":[";
 for(int i=0;i<=bound;i++){if(i)cout<<",";cout<<failed[i].size();}cout<<"],\"quotient_path_pauli_masks\":[";for(unsigned i=0;i<path.size();i++){if(i)cout<<",";cout<<path[i];}cout<<"]}\n";
 return interrupted?2:0;
}
