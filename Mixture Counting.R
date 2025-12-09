# ---
# title: "Mixture Counting"
# author: "Joice Ocrisa"
# ---
  
# {r setup, include=FALSE}
library(rstan)


# Stan Model ====================================================================
# NORMAL
normal_code <- "
data { 
      int N; 
      vector[N] y; 
}
parameters { 
      real mu; 
      real<lower=0> sigma; 
}
model {
      mu ~ normal(0,20);
      sigma ~ cauchy(0,5);
      y ~ normal(mu, sigma);
}

generated quantities {
      real logpdf[N];
      real tot = 0;
      for(i in 1:N){
        logpdf[i] = normal_lpdf(y[i] | mu, sigma);
        tot += logpdf[i];
  }
}
"

# GAMMA
gamma_code <- "
data { 
      int N; 
      vector[N] y; 
}
parameters { 
      real<lower=0> alpha; 
      real<lower=0> beta; 
}
model {
      alpha ~ exponential(1);
      beta ~ exponential(1);
      y ~ gamma(alpha, beta);
}
generated quantities {
      real logpdf[N];
      real tot = 0;
      for(i in 1:N){
        logpdf[i] = gamma_lpdf(y[i] | alpha, beta);
        tot += logpdf[i];
  }
}
"

# EKSPONENSIAL
exp_code <- "
data { 
      int N; 
      vector[N] y; 
}
parameters { 
      real<lower=0> lambda; 
}
model {
      lambda ~ exponential(1);
      y ~ exponential(lambda);
}
generated quantities {
      real logpdf[N];
      real tot = 0;
      for(i in 1:N){
        logpdf[i] = exponential_lpdf(y[i] | lambda);
        tot += logpdf[i];
  }
}
"
