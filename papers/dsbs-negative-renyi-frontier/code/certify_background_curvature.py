#!/usr/bin/env python3
"""Rational interval certificate for the fixed binary background.

Every interval endpoint is an integer multiple of 2**(-BITS).  All arithmetic
uses integer outward rounding.  exp and log use positive Taylor series with
explicit geometric tail bounds; sqrt uses integer square roots.  No floating
point result is used in the certificate's acceptance condition.
"""

from argparse import ArgumentParser
from dataclasses import dataclass
from fractions import Fraction
from math import isqrt
from pathlib import Path
import json

BITS = 160
SCALE = 1 << BITS
EXP_TERMS = 100
LOG_TERMS = 256


def ceildiv(a, b):
    return -((-a) // b)


@dataclass(frozen=True)
class I:
    lo: int
    hi: int

    @classmethod
    def rational(cls, x):
        x = Fraction(x)
        return cls(x.numerator * SCALE // x.denominator,
                   ceildiv(x.numerator * SCALE, x.denominator))

    @classmethod
    def box(cls, lo, hi):
        return cls(cls.rational(lo).lo, cls.rational(hi).hi)

    def __add__(self, other):
        other = cv(other)
        return I(self.lo + other.lo, self.hi + other.hi)

    __radd__ = __add__

    def __neg__(self):
        return I(-self.hi, -self.lo)

    def __sub__(self, other):
        return self + (-cv(other))

    def __rsub__(self, other):
        return cv(other) + (-self)

    def __mul__(self, other):
        other = cv(other)
        vals = (self.lo*other.lo, self.lo*other.hi,
                self.hi*other.lo, self.hi*other.hi)
        return I(min(vals)//SCALE, ceildiv(max(vals), SCALE))

    __rmul__ = __mul__

    def reciprocal(self):
        if self.lo <= 0 <= self.hi:
            raise ArithmeticError('division interval contains zero')
        vals = (Fraction(SCALE*SCALE, self.lo),
                Fraction(SCALE*SCALE, self.hi))
        low, high = min(vals), max(vals)
        return I(low.numerator//low.denominator,
                 ceildiv(high.numerator, high.denominator))

    def __truediv__(self, other):
        return self * cv(other).reciprocal()

    def __rtruediv__(self, other):
        return cv(other) * self.reciprocal()

    def square(self):
        low = 0 if self.lo <= 0 <= self.hi else min(self.lo*self.lo, self.hi*self.hi)
        high = max(self.lo*self.lo, self.hi*self.hi)
        return I(low//SCALE, ceildiv(high, SCALE))

    def sqrt(self):
        if self.lo < 0:
            raise ArithmeticError('negative square root')
        low = isqrt(self.lo*SCALE)
        high = isqrt(self.hi*SCALE)
        if high*high < self.hi*SCALE:
            high += 1
        return I(low, high)

    def exp(self):
        if self.lo < 0:
            if self.hi <= 0:
                return (-self).exp().reciprocal()
            return I(I(self.lo,self.lo).exp().lo, I(self.hi,self.hi).exp().hi)
        term = cv(1)
        total = cv(1)
        for j in range(1, EXP_TERMS + 1):
            term = term*self/j
            total = total + term
        next_term = term*self/(EXP_TERMS+1)
        ratio = self/(EXP_TERMS+2)
        if ratio.hi >= SCALE:
            raise ArithmeticError('exponential tail ratio not below one')
        tail = next_term/(1-ratio)
        return I(total.lo, total.hi+tail.hi)

    def log(self):
        if self.lo <= 0:
            raise ArithmeticError('nonpositive logarithm')
        if self.hi <= SCALE:
            return -self.reciprocal().log_positive()
        if self.lo < SCALE:
            return I(I(self.lo,self.lo).log().lo, I(self.hi,self.hi).log_positive().hi)
        return self.log_positive()

    def log_positive(self):
        if self.lo < SCALE:
            raise ArithmeticError('log_positive requires x>=1')
        if self.lo >= 2*SCALE:
            reduced = self
            power = 0
            while reduced.lo >= 2*SCALE:
                reduced = reduced/2
                power += 1
            return reduced.log_positive()+power*cv(2).log_series()
        return self.log_series()

    def log_series(self):
        y = (self-1)/(self+1)
        y2 = y.square()
        if y2.hi >= SCALE:
            raise ArithmeticError('logarithm tail ratio not below one')
        term = y
        total = cv(0)
        for j in range(LOG_TERMS):
            total = total + term/(2*j+1)
            term = term*y2
        tail = 2*term/((2*LOG_TERMS+1)*(1-y2))
        return I(2*total.lo, 2*total.hi+tail.hi)

    def acosh(self):
        if self.lo < SCALE:
            raise ArithmeticError('acosh requires x>=1')
        return (self+(self.square()-1).sqrt()).log()

    def tanh(self):
        e = (2*self).exp()
        return (e-1)/(e+1)

    def endpoints(self):
        return [str(Fraction(self.lo,SCALE)), str(Fraction(self.hi,SCALE))]


def cv(x):
    return x if isinstance(x,I) else I.rational(x)


def curvature(u, t):
    # A(s)=log(1/2)+2 log cosh(y), u=1+s, v=t/u,
    # z=acosh(exp(v)), y=u*z/2.
    v = t/u
    ev = v.exp()
    z = ev.acosh()
    sinh2 = ev.square()-1
    coth = ev/sinh2.sqrt()
    y = u*z/2
    ty = y.tanh()
    first = (1-ty.square())*(z-v*coth).square()/2
    second = v.square()*ty*coth/(u*sinh2)
    return first-second


def profile(s, epsilon):
    u=1+cv(s)
    t=((1-epsilon)/epsilon).log()
    z=(t/u).exp().acosh()
    y=u*z/2
    # cosh(y)=(exp(y)+exp(-y))/2
    ey=y.exp()
    return (2*epsilon).log()+2*((ey+1/ey)/2).log()


def derivatives_at_zero(epsilon):
    t=((1-epsilon)/epsilon).log()
    et=t.exp()
    x=et.acosh()
    z=(1-1/et.square()).sqrt()
    y=x/2
    ty=y.tanh()
    sy2=1-ty.square()
    y1=(x-t/z)/2
    y2=-t.square()*(1-z.square())/(2*z*z*z)
    y3=t.square()*(1-z.square())/(2*z*z*z)*(3+t-3*t/z.square())
    first=2*ty*y1
    second=2*(sy2*y1.square()+ty*y2)
    third=2*(-2*sy2*ty*y1*y1*y1+3*sy2*y1*y2+ty*y3)
    return first,second,third


def phase_k(epsilon):
    root=(1-2*epsilon).sqrt()
    ratio=((1+root)/(1-root)).log()
    return (1-epsilon)/epsilon*(1-root*((1-epsilon)/epsilon).log()/ratio).square()


def certify_extensions(cells):
    quarter=cv(Fraction(1,4))
    target=cv(Fraction(1,100))
    t_bg=cv(3).log()
    t_target=cv(99).log()
    maximum_pair=None
    maximum_diagonal=None
    for j in range(cells):
        u=I.box(Fraction(cells+j,cells),Fraction(cells+j+1,cells))
        bg=curvature(u,t_bg)
        pair=bg+curvature(u,t_target)
        ev=(t_bg/u).exp()
        diagonal=t_bg.square()*ev/((1+ev).square()*u*u*u)
        ten=diagonal+10*bg
        maximum_pair=pair.hi if maximum_pair is None else max(maximum_pair,pair.hi)
        maximum_diagonal=ten.hi if maximum_diagonal is None else max(maximum_diagonal,ten.hi)
        if pair.hi>=0:
            raise AssertionError(f'full-support example curvature failed at {j}')
        if ten.hi>=0:
            raise AssertionError(f'ten-copy example curvature failed at {j}')
    w_target,target_second,_=derivatives_at_zero(target)
    w_bg,bg_second,_=derivatives_at_zero(quarter)
    initial_gap=profile(Fraction(1,10),target)/Fraction(1,10)-w_target
    if initial_gap.lo*SCALE <= 0 or 10000*initial_gap.lo <= SCALE:
        raise AssertionError('initial standalone premium is not certified > 1/10000')
    diag_second=cv(Fraction(3,16))*t_bg.square()
    nine_second=diag_second+9*bg_second
    if nine_second.lo<=0:
        raise AssertionError('nine copies not proved insufficient')
    e_lo=cv(Fraction('0.0551046517029798'))
    e_hi=cv(Fraction('0.0551046517029799'))
    k_lo=phase_k(e_lo)
    k_hi=phase_k(e_hi)
    if k_lo.lo <= SCALE or k_hi.hi >= SCALE:
        raise AssertionError('critical root not bracketed')
    e_box=I(e_lo.lo,e_hi.hi)
    _,_,third=derivatives_at_zero(e_box)
    B=-third/6
    if B.lo<=0:
        raise AssertionError('critical cubic sign not established')
    return {
        'result':'PASS','cells':cells,'bits':BITS,
        'full_support_example':{
            'target':'DSBS(1/100)','background':'DSBS(1/4)',
            'minimal_background_copies_for_all_orders':1,
            'strict_standalone_infinite_order_premium_lower_bound':'1/10000 nats',
            'standalone_test_slope':'1/10','standalone_gap_interval':initial_gap.endpoints(),
            'joint_profile_second_derivative_global_upper':str(Fraction(maximum_pair,SCALE)),
            'joint_rate_exact':'C_W(DSBS(1/100))+C_W(DSBS(1/4))',
            'joint_Wyner_interval':(w_target+w_bg).endpoints(),
        },
        'diagonal_example':{
            'target':'diag(3/4,1/4)','background':'DSBS(1/4)',
            'minimal_background_copies_for_all_orders':10,
            'ten_copy_second_derivative_global_upper':str(Fraction(maximum_diagonal,SCALE)),
            'nine_copy_second_derivative_at_zero':nine_second.endpoints(),
            'logic':'Ten-copy joint potential is concave; nine-copy potential has strictly positive second derivative at zero.'
        },
        'critical_boundary':{
            'epsilon_bracket':['0.0551046517029798','0.0551046517029799'],
            'k_at_left':k_lo.endpoints(),'k_at_right':k_hi.endpoints(),
            'A_third_derivative_at_zero':third.endpoints(),
            'B_minus_A_third_over_six':B.endpoints(),
            'uniqueness_input':'Inherited unique-crossing theorem for k(epsilon)=1.',
        },
        'arithmetic':'same outward-rounded integer dyadic interval implementation as the background certificate',
        'floating_point_used_for_acceptance':False,
    }


def certify(cells):
    t = cv(3).log()
    largest_upper = None
    smallest_lower = None
    worst_cell = None
    for j in range(cells):
        u = I.box(Fraction(cells+j,cells), Fraction(cells+j+1,cells))
        value = curvature(u,t)
        if largest_upper is None or value.hi > largest_upper:
            largest_upper, worst_cell = value.hi, j
        if smallest_lower is None or value.lo < smallest_lower:
            smallest_lower = value.lo
        if 50*value.hi > -SCALE:
            raise AssertionError(f'uncertified curvature cell {j}/{cells}: {value.endpoints()}')
    return {
        'result':'PASS',
        'claim':'For every s in [0,1], A_DSBS(1/4),c=1_second_derivative(s) <= -1/50.',
        'consequence':'A(s) <= C_W(DSBS(1/4))*s - s^2/100; therefore d_* >= 1/100.',
        'arithmetic':'outward rounded integer dyadic intervals; exp/log series with analytic tails; integer sqrt',
        'bits':BITS,'exponential_terms':EXP_TERMS,'logarithm_terms':LOG_TERMS,
        'cells':cells,'u_domain':['1','2'],'s_domain':['0','1'],
        'log3_interval':t.endpoints(),
        'global_second_derivative_interval':I(smallest_lower,largest_upper).endpoints(),
        'worst_cell':worst_cell,
        'acceptance':'50 * upper_endpoint_integer <= -2**160 on every closed interval',
        'floating_point_used_for_acceptance':False,
    }


if __name__ == '__main__':
    ap=ArgumentParser()
    ap.add_argument('--cells',type=int,default=2048)
    ap.add_argument('--output',type=Path)
    ap.add_argument('--extensions',action='store_true')
    args=ap.parse_args()
    result=certify_extensions(args.cells) if args.extensions else certify(args.cells)
    text=json.dumps(result,indent=2)+'\n'
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(text)
    print(text)
