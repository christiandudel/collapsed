# Collapsing binary predictors

Christian Dudel, dudel@demogr.mpg.de

Simple simulation script to assess the impact of collapsing dummy predictors of 
opposite signs into one dummy. Proof of concept.

The idea is as follows. Assume that the data generating process is given by 
$y_i=a+b_1d_1+b_2d_2+e_i$. $y_i$ is some outcome variable for unit $i$, $a$ is 
a constant, and $e_i$ is a well-behaved error term. $d_i$ is a categorical 
variable with three categories 0, 1, and 2, and $d_1$ and $d_2$ are dummy 
variables indicating if $d$ equals 1 or 2, respectively, and dropping the 
subscript. Further assume that there is an assignment process for $d$ which 
depends on time $t$. For instance, the probability of $d=1$ could increase with 
time, the probability of $d=2$ could decrease, and the probability for $d=0$ 
could stay constant.

Now assume that instead of the correct model, a misspecified regression is
estimated: $y_i=k+b_t t + b_c c_i+f_i$. Here, $b_t$ is a slope for time $t$; 
$c_i$ is a collapsed version of $d_1$ and $d_2$, and it equals 1 if $d$ either 
equals 1 or 2; $f_i$ again is a well-behaved error term. The estimate of $b_t$
should be around zero. However, depending on $b_1$ and $b_2$ and due to the
fact how the data-generating process is set up, it is feasible to produce
severly biased estimates of $b_t$ when controlling for $c_i$ instead of $d_1$
and $d_2$.