PagSeguro.configure do |config|
  config.token       = "seu token"
  config.email       = "seu e-mail"
  config.environment = :production # ou :sandbox. O padrão é production.
  config.encoding    = "UTF-8" # ou ISO-8859-1. O padrão é UTF-8.
end
    
