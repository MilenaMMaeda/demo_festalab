class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :phone, presence: true, format: { with: /\A\(?(\d{2})\)?[-. ]?(\d{4,5})[-. ]?(\d{4})\z/ }
  # validates :cpf, presence: true, format: { with: /[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}\-?[0-9]{2}/ }
  validate :validar_cpf_formato

  private

  def validar_cpf_formato
    errors.add(:cpf, 'inválido') unless cpf_valido?
  end

  def cpf_valido?
    cpf = self.cpf.to_s.gsub(/\D/, '')

    return false unless cpf.length == 11
    return false if cpf.chars.uniq.length == 1

    total = 0
    9.times do |i|
      total += cpf[i].to_i * (10 - i)
    end
    primeiro_digito = total % 11
    primeiro_digito = (primeiro_digito < 2) ? 0 : 11 - primeiro_digito

    return false unless primeiro_digito == cpf[9].to_i

    total = 0
    10.times do |i|
      total += cpf[i].to_i * (11 - i)
    end
    segundo_digito = total % 11
    segundo_digito = (segundo_digito < 2) ? 0 : 11 - segundo_digito

    return false unless segundo_digito == cpf[10].to_i

    true
  end
end
