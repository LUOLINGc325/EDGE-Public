from itertools import product, combinations
from functools import lru_cache
from random import Random

PENDING = -1
DONE = -2


def partitions(items):
    if not items:
        yield ()
    else:
        v, *rest = items
        for partition in partitions(rest):
            yield tuple(sorted((*partition, (v,))))
            for i, block in enumerate(partition):
                yield tuple(sorted((*partition[:i], *partition[i+1:], tuple(sorted((*block,v))))))


def algorithm(graph, program, q):
    def add(out, goals, blocks, private, cost):
        state = goals, tuple(sorted(blocks)), private
        out[state] = min(cost, out.get(state, float("inf")))

    @lru_cache(None)
    def solve(nice):
        tag, bag, *args = nice
        out = {}
        if tag == "leaf":
            return {((),(),()): 0}
        if tag == "in":
            child, v = args
            old = child[1]
            for (goals, blocks, private), cost in solve(child).items():
                goal = dict(zip(old, goals))
                pct = dict(zip(old, private))
                affected = [u for u in old if goal[u] == PENDING and u in graph[v]]
                for mask in range(1 << len(affected)):
                    new_clients = [u for i,u in enumerate(affected) if (mask >> i)&1]
                    these_goals = goal | {u:v for u in new_clients}
                    for new_blocks in partitions(new_clients):
                        if len(new_blocks) > q or any(w in graph[u] for b in new_blocks for u,w in combinations(b,2)):
                            continue
                        add(out,tuple((these_goals|{v:PENDING})[u] for u in bag),blocks+new_blocks,
                            tuple((pct|{v:0})[u] for u in bag),cost)
                        for leader in set(old) & graph[v]:
                            lg = tuple((these_goals|{v:leader})[u] for u in bag)
                            lblocks = [b for b in blocks if goal[b[0]] == leader]
                            for block in lblocks:
                                if not (set(block) & graph[v]):
                                    nb = tuple(b for b in blocks if b!=block) + (tuple(sorted((*block,v))),)
                                    add(out,lg,nb+new_blocks,tuple((pct|{v:0})[u] for u in bag),cost)
                            if pct[leader]:
                                pc = pct | {leader:pct[leader]-1, v:0}
                                add(out,lg,blocks+new_blocks+((v,),),tuple(pc[u] for u in bag),cost)
                            if len(lblocks)+pct[leader] < q:
                                add(out,lg,blocks+new_blocks+((v,),),tuple((pct|{v:0})[u] for u in bag),cost)
        if tag == "out":
            child,v=args
            old=child[1]
            for (g,b,p),cost in solve(child).items():
                goals=dict(zip(old,g))
                if goals[v]==PENDING:
                    continue
                private=dict(zip(old,p))
                blocks=[]
                pay=private[v]
                for group in b:
                    leader=goals[group[0]]
                    if leader==v:
                        pay+=1
                    elif v in group:
                        group=tuple(u for u in group if u!=v)
                        if group:
                            blocks.append(group)
                        else:
                            private[leader]+=1
                    else:
                        blocks.append(group)
                goal=tuple(DONE if goals[u]==v else goals[u] for u in bag)
                add(out,goal,blocks,tuple(private[u] for u in bag),cost+pay)
        if tag=="join":
            a,b=args
            for (ga,pa,ca),va in solve(a).items():
                for (gb,pb,cb),vb in solve(b).items():
                    if pa!=pb:
                        continue
                    if any((u!=v and set((u,v))!={PENDING,DONE}) or u==v==DONE
                           for u,v in zip(ga,gb)):
                        continue
                    goals=tuple(min(u,v) if u<0 and v<0 else u for u,v in zip(ga,gb))
                    counts={u:0 for u in bag}
                    for block in pa:
                        counts[goals[bag.index(block[0])]]+=1
                    private_ranges=[range(max(ca[i],cb[i]),1+min(ca[i]+cb[i],q-counts[u]))
                                    for i,u in enumerate(bag)]
                    for priv in product(*private_ranges):
                        add(out,goals,pa,priv,va+vb)
        return out
    return solve(program).get(((),(),()),float("inf"))


def brute(graph):
    n=len(graph)
    good=[0]*(1<<n)
    for mask in range(1,1<<n):
        chosen=[v for v in range(n) if mask>>v&1]
        good[mask]=int(not any(v in graph[u] for u,v in combinations(chosen,2))
                       and any(all(v in nbr for v in chosen) for nbr in graph))
    F=[0]+[float("inf")]*((1<<n)-1)
    for mask in range(1,1<<n):
        sub=mask
        while sub:
            if good[sub]:
                F[mask]=min(F[mask],1+F[mask^sub])
            sub=(sub-1)&mask
    return F[-1]


def leaf(bag=()):
    return ("leaf",bag)


def introduce(t,u):
    return ("in",tuple(sorted((*t[1],u))),t,u)


def forget(t,u):
    return ("out",tuple(v for v in t[1] if v!=u),t,u)


def chain(bag, interior):
    t=leaf()
    for u in (*bag,*interior):
        t=introduce(t,u)
    for u in interior:
        t=forget(t,u)
    return t


def sample(rng):
    n=rng.randrange(1,9)
    bag=list(range(rng.randrange(0,min(n+1,4))))
    sidea=list(range(len(bag),n,2))
    sideb=list(range(len(bag)+1,n,2))
    edges=set(combinations((*bag,*sidea),2)) | set(combinations((*bag,*sideb),2))
    d=rng.random()
    graph=[set() for _ in range(n)]
    for u,v in edges:
        if rng.random()<d:
            graph[u].add(v)
            graph[v].add(u)
    t=("join",tuple(bag),chain(bag,sidea),chain(bag,sideb))
    w=max(len(bag)+len(sidea),len(bag)+len(sideb))-1
    for u in reversed(bag):
        t=forget(t,u)
    return graph,t,w


def main():
    rng=Random(7011)
    passed=0
    for i in range(550):
        G,T,w=sample(rng)
        if w>4:
            continue
        got=algorithm(G,T,w+1)
        expected=brute(G)
        assert got==expected,(G,T,got,expected)
        passed+=1
    print("Independent compressed algorithm agrees with partition oracle on",passed,
          "seeded graph/decompositions including joins and infeasible isolates")


if __name__=="__main__":
    main()
