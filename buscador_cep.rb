require 'faraday'       # importa a gem faraday para fazer requisições HTTP
require 'json'          # importa o módulo json para que possamos usar a classe JSON e suas funções

puts 'Digite um CEP:'   # apresenta uma mensagem no terminal de comandos
cep = gets.chomp        # lê uma string do terminal de comandos

# envia uma requisição HTTP com o verbo GET para o endereço https://brasilapi.com.br/api/cep/v1/#{cep}
# #{cep} será substituído pelo valor da variável cep
resposta = Faraday.get("https://brasilapi.com.br/api/cep/v1/#{cep}")

# parse é uma função da classe JSON que transforma uma string (resposta.body) para um hash
# isso facilita acessar as propriedades do corpo da resposta HTTP usando corpo['nome_da_propriedade']
corpo = JSON.parse(resposta.body)

# apresenta no terminal o status da resposta HTTP
puts "Status da resposta: #{resposta.status}"

# avalia o valor contido em resposta.status
case resposta.status

# quando resposta.status for 200, então apresente os dados do CEP
when 200
    # apresenta na tela o estado do CEP
    puts "Estado: #{corpo['state']}"
    # apresenta na tela a cidade do CEP
    puts "Cidade: #{corpo['city']}"
    # apresenta na tela o bairro do CEP
    puts "Bairro: #{corpo['neighborhood']}"
    # apresenta na tela a rua do CEP
    puts "Logradouro: #{corpo['street']}"

# quando a resposta.status for 404, então o CEP é inválido
when 404
    puts "CEP inválido."

# quando resposta.status estiver entre 500 e 599, isso indica que houve um erro de servidor na API
when 500..599
    puts "Erro na API. Tente novamente mais tarde."

end
