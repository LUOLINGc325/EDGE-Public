"""Nonrecursive rational product and schedules; independent of optimization."""
from fractions import Fraction as F

def parameter(m):
    if m<3:raise ValueError("require m >= 3")
    h=(m+1)//2
    return F(h-2,2*(2*h-1))

def correction(r,c):
    if r<0 or not 0<=c<=F(1,4):raise ValueError("invalid parameter")
    if c==0:return F(0)
    z=1/(3*c);p=min(r,z.numerator//z.denominator)
    value=3*c*(1-3*p*c)/(1+2*c)
    for j in range(p+1,r+1):value*=1-1/(3*j*c)
    return value

def deficit_at(r,c):
    return (1+3*c)/(3*(r+1)+correction(r,c))

def deficit(r,m):
    if r<0 or m<2:raise ValueError("require r >= 0, m >= 2")
    return F(0) if m==2 else deficit_at(r,parameter(m))

def first_fraction(r,m):
    if r<1 or m<2:raise ValueError("require r >= 1, m >= 2")
    if m==2:return F(1)
    c=parameter(m);v=F(1,3*r)
    if c<=v:return 1/(1+r*(1-c))
    w=deficit_at(r-1,c)
    return (w-v)/(c+w-v)

def infinite_deficit(r):
    if r<0:raise ValueError("require r >= 0")
    if r==0:return F(1,2)
    p=F(1)
    for j in range(2,r+1):p*=1-F(4,3*j)
    return 1/(F(12*(r+1),7)+p/14)
