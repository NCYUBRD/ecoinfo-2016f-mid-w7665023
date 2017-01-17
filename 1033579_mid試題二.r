#請使用 for 迴圈列出 15 個費布納西(Fibonacci)數列
n=15
fib=integer(n)
fib[1]=0
fib[2]=1
for (x in 3:n) {
  fib[x]= fib[x-1] + fib[x-2]
}
fib

