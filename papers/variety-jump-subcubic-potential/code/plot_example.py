"""Draw the exact seven-vertex example; no inferred or generated graph data."""
from pathlib import Path
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Circle

BASE = Path(__file__).resolve().parents[1]
EDGES = [(0,3),(3,4),(4,1),(1,5),(5,2),(1,6)]
POS = {0:(0,0),3:(1,0),4:(2,0),1:(3,0),5:(4,0),2:(5,0),6:(3,1.2)}
BEFORE = {0:'R',1:None,2:None,3:'R',4:'R',5:'R',6:'B'}
AFTER = {0:None,1:'R',2:None,3:'R',4:'R',5:'R',6:'B'}

plt.rcParams.update({'font.family':'DejaVu Sans','font.size':11,'axes.titlesize':15})
fig,axs=plt.subplots(2,1,figsize=(9.0,5.8))
fig.set_facecolor('#ffffff')
for ax,q,title,detail in zip(axs,[BEFORE,AFTER],
        ['Before: vacancies at 1 and 2','After: agent at 0 jumps to 1'],
        ['Utility at 0 = 0    |    Old potential = 10    |    New potential Ψ = 56',
         'Utility at 1 = 1    |    Old potential = 10    |    New potential Ψ = 48']):
    for v,w in EDGES:
        ax.plot([POS[v][0],POS[w][0]],[POS[v][1],POS[w][1]],color='#91a0af',lw=2,zorder=0)
    for v,(x,y) in POS.items():
        color={'R':'#a83c32','B':'#286799',None:'#ffffff'}[q[v]]
        circle=Circle((x,y),.19,facecolor=color,edgecolor='#24364b',lw=1.4,
                      linestyle='--' if q[v] is None else '-',zorder=2)
        ax.add_patch(circle)
        ax.text(x,y,str(v),ha='center',va='center',color='#24364b' if q[v] is None else 'white',weight='bold')
        ax.text(x,y-.34,'vacant' if q[v] is None else f'type {q[v]}',ha='center',va='top',fontsize=9,color='#46576a')
    ax.set_title(title,loc='left',pad=4,color='#15283e')
    ax.text(0,-.93,detail,color='#24364b',fontsize=11)
    ax.set_xlim(-.4,5.4);ax.set_ylim(-1.1,1.65);ax.set_aspect('equal');ax.axis('off')
fig.subplots_adjust(left=.06,right=.98,bottom=.035,top=.93,hspace=.25)
out=BASE/'figures';out.mkdir(exist_ok=True)
fig.savefig(out/'seven_vertex_example.pdf',bbox_inches='tight')
fig.savefig(out/'seven_vertex_example.png',dpi=190,bbox_inches='tight')
print(out/'seven_vertex_example.pdf')
