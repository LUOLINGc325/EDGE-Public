"""Direct integer-only verification, independent of SAT and original probe."""
from itertools import product, combinations
from collections import Counter
from pathlib import Path
import json

BASE7 = [0,3,5,2,5,3,2]
F7 = [[(d*BASE7[(pow(d,-1,7)*z)%7])%7 for z in range(7)] for d in (1,2,3)]
F5 = [[0,2,4,1,3]]
F6 = [[0,2,3,1,1,1], [0,2,4,4,1,2]]

def guess(q, tab, center, other):
    return (center+tab[(other-center)%q])%q

def both_wrong(q, tab, center, x,y):
    return guess(q,tab,center,y)!=x and guess(q,tab,center,x)!=y

def verify(q,tabs):
    # Directly enumerate all tuples seen by the center, not SAT's normalized variables.
    pairs=list((x,y) for x in range(q) for y in range(q) if x!=y)
    possible_counts=Counter()
    totalproper=0; leaf_won=0; center_needed=0
    separated_pairs=[[]for tab in tabs]
    for c,d in combinations(range(q),2):
        separating=[]
        for i,tab in enumerate(tabs):
            shared=[(x,y) for x,y in pairs if c not in (x,y) and d not in (x,y)
                    and both_wrong(q,tab,c,x,y) and both_wrong(q,tab,d,x,y)]
            if not shared: separating.append(i);separated_pairs[i].append([c,d])
        if not separating:raise RuntimeError(('unseparated center pair',q,c,d))
    for exterior in product(pairs,repeat=len(tabs)):
        possible=[]
        for c in range(q):
            if any(c in xy for xy in exterior):continue
            totalproper+=1
            if all(both_wrong(q,tab,c,*xy) for tab,xy in zip(tabs,exterior)):
                possible.append(c);center_needed+=1
            else: leaf_won+=1
        if len(possible)>1:raise RuntimeError(('ambiguous root',q,exterior,possible))
        possible_counts[len(possible)]+=1
        decoder=possible[0] if possible else 0
        for c in possible:
            if decoder!=c:raise RuntimeError(('decoder failure',q,exterior,c))
    expected=q*((q-1)*(q-2))**len(tabs)
    if totalproper!=expected:raise RuntimeError(('count mismatch',totalproper,expected))
    return dict(q=q,blades=len(tabs),tables=tabs,proper_colorings=totalproper,
                exterior_observations=len(pairs)**len(tabs),leaf_won=leaf_won,
                center_needed=center_needed,root_survivor_histogram=dict(possible_counts),
                separated_center_pairs=separated_pairs,result='all verified')

out={'method':'direct exhaustive integer verification independent of SAT',
     'results':[verify(5,F5),verify(6,F6),verify(7,F7)],
     'upper_count_certificates': {
       'two_blades_q7':{'leaf_pair_domain':30,'two_guess_union_bound':12,'remaining_at_least':18,
                        'all_root_candidates_lower_bound':7*18**2,'exterior_observations':42**2},
       'arbitrary_blades_q8':{'two_root_colors':2,'remaining_leaf_colors':6,
                              'ordered_distinct_leaf_pairs':30,'four_guesses_union_bound':24,
                              'common_failures_at_least':6}}}
assert out['upper_count_certificates']['two_blades_q7']['all_root_candidates_lower_bound']>out['upper_count_certificates']['two_blades_q7']['exterior_observations']
import argparse
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', type=Path, default=Path(__file__).resolve().parents[1]/'results'/'verified_windmill.json')
p=parser.parse_args().output
p.parent.mkdir(parents=True, exist_ok=True)
p.write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
