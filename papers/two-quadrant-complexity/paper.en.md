---
title: "A two-quadrant complexity boundary for domination in split rectangle graphs"
subtitle: "Exact covering hardness with polynomial packing"
lang: en
---

# A two-quadrant complexity boundary for domination in split rectangle graphs

## Abstract

We prove that minimum domination is NP-complete on a restricted class of split rectangle intersection graphs. The clique rectangles all contain the origin. The independent rectangles lie in only two opposite quadrants and each meets exactly two clique rectangles. Each clique rectangle meets at most three independent ones. The reduction constructs two linear-forest edge orders by subdividing a degree-three graph and encodes the two orders in the extents of a rectangle. It preserves approximation gaps and allows arbitrarily large fixed girth in the associated incidence graph. Maximum closed-neighborhood packing remains polynomial on the restricted class, and the sharp domination-to-packing ratio is two. On one occupied quadrant both quantities are polynomially computable.

## 1. Model and results

An axis-parallel rectangle intersection graph has one vertex per closed rectangle and edges when rectangles meet. A split presentation supplies a clique C and an independent set I. The task is minimum cardinality domination, or equivalently covering all vertices by closed graph neighborhoods. A packing is a set of vertices whose closed neighborhoods are pairwise disjoint. Write γ and ρ for the optimum domination and packing numbers.

The archived *Domination and packing in split rectangle intersection graphs* proves a sharp factor four and a near-linear approximation by combining interval covers in up to four quadrants. Its single-quadrant subroutine is exact. We ask whether two opposite occupied quadrants already make exact optimization difficult.

**Theorem 1.** The domination decision problem is NP-complete even on instances presented by nondegenerate rectangles and a split partition satisfying all of the following.

1. Every rectangle of C contains the origin.
2. Every rectangle of I is contained in the interior of one of two opposite quadrants.
3. Each vertex in I has exactly two neighbors in C, and each vertex in C has at most three neighbors in I.

The coordinates have O(log N) bits for instances of N rectangles. The auxiliary graph on C, whose edges are the neighbor pairs supplied by I, can be required to be simple and to have arbitrarily large fixed girth.

On the restricted family maximum packing is a maximum matching in the auxiliary graph whenever I is nonempty. The ratio γ/ρ has sharp bound two, and a two-approximation follows from any maximal matching. For the general split model with one occupied quadrant of projected demand points, both numbers are exactly computable by an interval-cover algorithm. Thus the complexity change already occurs between one occupied quadrant and two opposite ones.

## 2. Encoding vertex cover by two ordered lists

We first give a geometric encoding. Suppose the edges of a simple graph H are partitioned into two linear forests, that is, two subgraphs each consisting of paths and isolated vertices. In each forest, order the edges consecutively along its paths, concatenating the paths in arbitrary order. For each vertex v, its incident edges in either list are empty, one edge, or two consecutive edges.

Write M₁ and M₂ for the list lengths. For an edge at position i of list one, make its demand rectangle a square of half side length 1/8 about point (i,M₁+1−i). For an edge at position i of list two, use instead (−i,−(M₂+1−i)). The squares are pairwise disjoint and lie strictly in the first and third quadrants.

For each vertex v of H make a clique rectangle containing the origin. If v's interval in list one is [l,r], give the rectangle right extent r and upper extent M₁+1−l. For an empty interval set those extents to 1/4. Use the same rule for list two to determine the left and lower extents. All extents are positive, so the rectangles are nondegenerate and meet at the origin.

In the first quadrant the rectangle intersects the demand at i precisely when both i≤r and M₁+1−i≤M₁+1−l. For either failed inequality a center-coordinate gap of at least one exceeds the square's half side length. For a satisfied pair the center itself is inside the clique rectangle. The empty-interval extent meets no square. Reflection gives the same result for list two. Thus the independent-set rectangle of every edge is adjacent exactly to its two endpoint rectangles. The coordinates are bounded integers with a constant denominator, with magnitudes at most |E(H)|+1.

When H has an edge, a vertex cover is nonempty and its clique rectangles dominate every demand and the entire clique. Conversely, take any dominating set of the split graph. Each selected independent vertex can be replaced by either neighbor in C. Its closed neighborhood is contained in the closed neighborhood of that neighbor, because I is independent and C is a clique. After replacements the resulting subset of C still dominates and covers the neighbor pair of every demand. It gives a vertex cover of H of size no greater than the original domination set. Hence

~~~text
γ(split rectangle instance) = minimum vertex cover size of H.    (1)
~~~

For packing, two independent demand vertices have intersecting closed neighborhoods exactly when their corresponding edges share an endpoint. A selected clique vertex cannot coexist in a packing with any demand vertex, since its closed neighborhood includes the demand's two clique neighbors, and it cannot coexist with another clique vertex. For H with an edge its maximum matching therefore gives an optimum packing. The endpoints of any maximal matching form a vertex cover of size twice its cardinality. Thus γ≤2ρ on this incidence family, and an ordinary maximum-matching algorithm computes ρ. A triangle H has a two-edge path in one forest and one edge in the second, so its representation gives γ=2 and ρ=1.

## 3. Making the two edge orders without losing hardness

For completeness, vertex cover on graphs of maximum degree three is NP-hard by a direct reduction from 3-SAT. For a variable with r occurrences, use an even cycle alternating vertices A₁,B₁,…,A_r,B_r, with the two choices of maximum independent set representing the two truth values. For r=1 use a single edge; omit unused variables. For every clause, use a triangle with one vertex per literal occurrence. Join each clause vertex to the corresponding occurrence's variable vertex that is chosen when its literal is false. An independent set can take at most r vertices per variable and at most one from each clause. It attains the sum of those bounds exactly when every variable cycle takes one alternating class and every clause can choose a true literal. Each occurrence uses a separate pair on its cycle, so each vertex has degree at most three. Complementing the independent set gives the vertex cover decision threshold. This works with labeled occurrences even when a clause repeats a variable.

Given a degree-three graph G with at least one edge, replace each edge by a path of odd length 2t+1, for any fixed integer t≥1, with 2t new internal vertices. Call the resulting graph H. Fix any subset S of original vertices in a vertex cover of H. Every subdivided path needs at least t internal vertices in the cover, because the internal path has a matching of size t. When both endpoints are outside S it needs at least t+1: the first and last internal vertices are forced, and the remaining 2t−2 internal vertices have a disjoint matching of size t−1. These bounds are attained for each path. With at least one endpoint in S, choose the appropriate alternating set of t internal vertices. With neither endpoint in S, choose an alternating set and also add the other boundary vertex. Therefore the best completion of S has size

~~~text
|S| + t|E(G)| + #{edges of G with no endpoint in S}.
~~~

Adding one endpoint per uncovered edge turns S into a cover of G at the cost of at most that last count. Conversely an optimum cover of G completes using t vertices per path. Thus

~~~text
τ(H)=τ(G)+t|E(G)|,                                           (2)
~~~

where τ denotes minimum vertex cover size. A cover of H of size B can be transformed in polynomial time into a cover of G of size at most B−t|E(G)|.

To produce the edge orders, color the first path edge incident to each original vertex so that no color has more than two incident edges there. This is possible because the degree is at most three. The choices at different original vertices refer to distinct edges of H. If the two outer edges of one replaced path have the same color, color one internal edge of that path with the other color. Give all remaining internal edges either color. No entire replacement path is monochromatic. In each color the degree is at most two, and a monochromatic cycle is impossible: any cycle in H traverses every replacement path it enters in full, because the internal vertices have no other neighbors. Each color is therefore a linear forest, giving the required two orders in polynomial time.

A cycle in H is obtained by lifting a cycle of G with every edge replaced by 2t+1 edges, so any finite girth is at least 3(2t+1). Degree bounds stay at most three. Choosing t sufficiently large gives any prescribed fixed girth bound. This is a statement about the auxiliary graph H and not about the clique-containing rectangle graph.

Apply Section 2 to H. Equation (2) makes the domination threshold equal to the source cover threshold plus t|E(G)|. All demands and clique neighbor degrees satisfy Theorem 1. The polynomial-sized coordinates permit checking every adjacency and domination certificate in polynomial time, so the problem is in NP. This proves the claimed hardness and exact complexity.

## 4. Approximation and the independent packing optimum

The reduction preserves objective errors. Given a domination set D, the two transformations in Sections 2 and 3 give a cover of G of size at most |D|−t|E(G)|. Subtracting the optimal values shows

~~~text
returned cover size − τ(G) ≤ |D|−γ.
~~~

Also |E(G)|≤3τ(G) because every edge is met by a cover vertex of degree at most three. Thus γ≤(1+3t)τ(G). In particular a polynomial-time approximation scheme for these rectangle instances would give one for degree-three vertex cover, by using relative tolerance ε/(1+3t). This statement does not require an external approximation-hardness theorem.

The associated matching values have a parallel exact identity. Let ν denote maximum matching size. Any matching uses at most t+1 edges on each replacement path, and attaining t+1 saturates both original endpoints. The paths on which it attains t+1 therefore correspond to a matching of G. This bounds ν(H) by t|E(G)|+ν(G). Conversely a maximum matching of G lets its chosen paths take t+1 alternating edges, and all other paths take t edges entirely on their internal vertices. Hence

~~~text
ν(H)=ν(G)+t|E(G)|,    γ−ρ=τ(G)−ν(G).
~~~

The degree threshold can also be stated independently of geometry. On a split instance in which all demands have degree two and at least one demand exists, use the simple graph with one edge for each distinct pair of clique neighbors. The replacement argument gives domination equal to vertex cover, and packing equal to matching, including when several demands supply the same pair. If each clique vertex meets at most two demands, the auxiliary graph has maximum degree at most two. Its components are isolated vertices, paths, or cycles. Their minimum cover sizes are zero, the floor of half the vertex count for paths, and the ceiling of half the vertex count for cycles. They can be summed in linear time after building the graph. Theorem 1 makes degree three NP-complete even with the two-quadrant representation.

## 5. Exact computation with one occupied quadrant

Suppose the origin lies in all clique rectangles. Treat any independent demands with no clique neighbor as isolated vertices, adding each to both optima. If no demands remain, a nonempty remaining clique has both optima equal to one. Otherwise project each remaining independent rectangle to the nearest point to the origin, clipping the two coordinates separately to its closed coordinate intervals. A clique rectangle meets it if and only if it contains that point. In fact, if the rectangles meet, each clipped coordinate is between zero and an intersection point's coordinate, and the clique rectangle contains both endpoints of that coordinate interval. The converse uses that the clipped point belongs to the demand rectangle.

Assume all projected demand points are in one quadrant and take absolute values of both coordinates. An anchored clique rectangle contains all points coordinatewise below any point it contains. Keep only the coordinatewise maximal projected points, with one representative when points coincide. Covering these points covers all demands. Sort them by increasing first coordinate; the second coordinate is then strictly decreasing. Every clique rectangle covers a prefix for the first restriction and a suffix for the second, hence an interval after intersecting the restrictions.

At the first uncovered point choose an interval containing it with largest right endpoint. Repeat at the next uncovered point. The chosen rectangles cover all demands, and hence dominate the graph since they belong to its clique. The demand vertices at the recorded first uncovered points form a packing. No clique interval covering one recorded point can extend to the next recorded point, because that next point exceeds the farthest reachable right endpoint. Therefore the recorded demand vertices have disjoint closed neighborhoods. Every dominating set has size at least that of any packing, since it must meet each packed closed neighborhood. The interval procedure attains both optima. This is a polynomial algorithm. With the stated geometric lists, the interval construction is the same single-quadrant mechanism used by the pinned paper.

## 6. Scope

The lower bound applies to explicitly represented split rectangle intersection graphs, positive-area rectangles, and the ordinary unweighted cardinality objective. It adds an exact-complexity result to the archived quadrant approximation and local interval algorithm. The large-girth and approximation statements concern the associated degree-bounded cover graph. The two-quadrant family provides a polynomial exact packing computation even though its minimum domination computation is NP-complete. The source comparison is limited to the pinned repository record.
