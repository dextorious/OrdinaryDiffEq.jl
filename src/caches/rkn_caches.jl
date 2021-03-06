struct Nystrom4Cache{uType,rateType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  fsalfirst::rateType
  k₂::rateType
  k₃::rateType
  k₄::rateType
  k::rateType
  tmp::uType
end

u_cache(c::Nystrom4Cache) = ()
du_cache(c::Nystrom4Cache) = (c.fsalfirst,c.k₂,c.k₃,c.k₄,c.k)

# struct Nystrom4ConstantCache <: OrdinaryDiffEqConstantCache end

function alg_cache(alg::Nystrom4,u,rate_prototype,uEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,reltol,::Type{Val{true}})
  k₁ = zeros(rate_prototype)
  k₂ = zeros(rate_prototype)
  k₃ = zeros(rate_prototype)
  k₄ = zeros(rate_prototype)
  k  = zeros(rate_prototype)
  tmp = similar(u)
  Nystrom4Cache(u,uprev,k₁,k₂,k₃,k₄,k,tmp)
end

# alg_cache(alg::Nystrom4,u,rate_prototype,uEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,reltol,::Type{Val{false}}) = Nystrom4ConstantCache()

struct Nystrom4VelocityIndependentCache{uType,rateType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  fsalfirst::rateType
  k₂::rateType
  k₃::rateType
  k::rateType
  tmp::uType
end

u_cache(c::Nystrom4VelocityIndependentCache) = ()
du_cache(c::Nystrom4VelocityIndependentCache) = (c.fsalfirst,c.k₂,c.k₃,c.k)

function alg_cache(alg::Nystrom4VelocityIndependent,u,rate_prototype,uEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,reltol,::Type{Val{true}})
  k₁ = zeros(rate_prototype)
  k₂ = zeros(rate_prototype)
  k₃ = zeros(rate_prototype)
  k  = zeros(rate_prototype)
  tmp = similar(u)
  Nystrom4VelocityIndependentCache(u,uprev,k₁,k₂,k₃,k,tmp)
end

struct IRKN4Cache{uType,rateType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  uprev2::uType
  fsalfirst::rateType
  k₂::rateType
  k₃::rateType
  k::rateType
  tmp::uType
  onestep_cache::Nystrom4VelocityIndependentCache
end

u_cache(c::IRKN4Cache) = ()
du_cache(c::IRKN4Cache) = (c.fsalfirst,c.k₂,c.k₃,c.k,c.k_₁,c.k_₂,c.k_₃)

function alg_cache(alg::IRKN4,u,rate_prototype,uEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,reltol,::Type{Val{true}})
  k₁ = zeros(rate_prototype)
  k₂ = zeros(rate_prototype)
  k₃ = zeros(rate_prototype)
  k  = zeros(rate_prototype)
  tmp = similar(u)
  IRKN4Cache(u,uprev,uprev2,k₁,k₂,k₃,k,tmp,Nystrom4VelocityIndependentCache(u,uprev,k₁,k₂,k₃,k,tmp))
end

struct Nystrom5VelocityIndependentCache{uType,rateType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  fsalfirst::rateType
  k₂::rateType
  k₃::rateType
  k₄::rateType
  k::rateType
  tmp::uType
end

u_cache(c::Nystrom5VelocityIndependentCache) = ()
du_cache(c::Nystrom5VelocityIndependentCache) = (c.fsalfirst,c.k₂,c.k₃,c.k₄,c.k)

function alg_cache(alg::Nystrom5VelocityIndependent,u,rate_prototype,uEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,reltol,::Type{Val{true}})
  k₁ = zeros(rate_prototype)
  k₂ = zeros(rate_prototype)
  k₃ = zeros(rate_prototype)
  k₄ = zeros(rate_prototype)
  k  = zeros(rate_prototype)
  tmp = similar(u)
  Nystrom5VelocityIndependentCache(u,uprev,k₁,k₂,k₃,k₄,k,tmp)
end
