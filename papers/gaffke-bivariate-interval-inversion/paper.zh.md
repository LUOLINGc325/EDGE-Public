# 双变量 Gaffke 改进规则的精确反演与最大区间缩减

## 摘要

Ming 等提出一个有效、单调的双输入合并规则，在部分输入上严格改进 Gaffke 的原规则。他们未研究如何反演该规则以缩短两个有界观测的均值区间。本文给出区间端点的闭式公式、端点严格改进的充要条件，以及所有样本上最大长度缩减的唯一极值。单侧水平 $\alpha$ 很小时，最大缩减为 $\alpha/8+O(\alpha^2)$。

## 1. 精确反演

设两个独立观测在 $[0,1]$ 上且有共同均值。排序输入为 $0\le x\le y\le1$，单侧水平 $0<\alpha<1/2$。记 $s=\sqrt{1-\alpha}$、$u=1-s$。原规则及改进规则的下端点依次为

$$
L_{\rm old}=
\begin{cases}
\sqrt{\alpha xy},&x\ge\alpha y,\\
y-s\sqrt{y(y-x)},&x<\alpha y,
\end{cases}\qquad
L_{\rm ad}=
\begin{cases}
\sqrt{\alpha xy},&x\ge\alpha y,\\
(uy+\sqrt{u^2 y^2+4usxy})/2,&x<\alpha y.
\end{cases}
$$

上端点为 $1-L(1-y,1-x)$。当 $x=y=0$ 时下端点取零。两个闭区间均具有至少 $1-2\alpha$ 的覆盖率，且改进区间逐样本包含于原区间。

证明来自候选均值 $\theta$ 的三种比例区间。$\theta\le x$ 时，两规则都等于 $\theta^2/(xy)$。$\theta\ge y$ 时都等于一。若等号根在 $(x,y)$ 内，原规则为 $1-(y-\theta)^2/[y(y-x)]$；改进规则的拒绝条件等价于 $\theta^2-uy\theta-usxy\le0$。求根即得上式。规则对候选均值的单调性保证反演是区间。样本均值落在区间内，因为两个缩放值之和为二时，改进规则的相关二次式根至多为二，使其 $p$ 值至少为 $3/4$。覆盖率从原文的检验有效性和并集界得出。下端点严格增加当且仅当 $0<x<\alpha y$，上端点严格减少当且仅当 $0<1-y<\alpha(1-x)$。

## 2. 最大长度缩减

记 $r=x/y$，在 $0\le r\le\alpha$ 定义
$$G(r)=(u+\sqrt{u^2+4us r})/2-1+s\sqrt{1-r},$$
并在区间之外令 $G=0$。下端点提升为 $yG(r)$，上端点的缩减为 $(1-x)G(r')$，其中 $r'=(1-y)/(1-x)$。$G$ 在 $[0,\alpha]$ 严格凹，两端为零。单端点的最大归一化缩减位于 $r=3u/4$。

若两端都严格提升，其权重分别为 $(1-r')/(1-rr')$ 和 $(1-r)/(1-rr')$。设 $\bar r$ 为对应加权平均，则权重之和正好为 $2/(1+\bar r)$。Jensen 不等式使总长度缩减不超过 $2G(\bar r)/(1+\bar r)$，仅当 $r=r'$ 取等。只提升一端时也达不到全局最大，因为同一单端最优比的对称样本有两端提升。

故最大缩减由唯一比值 $r_*\in(0,\alpha)$ 决定，满足 $(1+r_*)G'(r_*)=G(r_*)$。其唯一排序样本是 $(r_* /(1+r_*),1/(1+r_*))$，最大缩减为 $2G(r_*)/(1+r_*)$。将 $r=\alpha t$ 后作一致展开，得 $r_*/\alpha\to3/8$，且最大缩减为 $\alpha/8+O(\alpha^2)$。

在单侧水平 $1/40$ 时，有理区间算法认证最大缩减介于 $0.003093358034$ 与 $0.003093358035$ 之间。最优样本约为 $(0.00927025,0.99072975)$。

## 参考文献

- Jiahao Ming, Aaditya Ramdas, Yi Shen, Ruodu Wang and Ian Waudby-Smith. *Gaffke's confidence interval for the mean of bounded data is inadmissible but asymptotically efficient*. arXiv:2607.18661v1，尤其 §4.4。 [全文](https://arxiv.org/abs/2607.18661)
