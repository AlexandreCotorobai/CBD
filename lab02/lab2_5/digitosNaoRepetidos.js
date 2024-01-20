function digitosNaoRepetidos(phones) {
    const result = [];

    // Função para verificar se um número tem dígitos não repetidos
    function hasUniqueDigits(number) {
        const numStr = number.display.split("-")[1];
        const uniqueDigits = [...new Set(numStr)];
        return uniqueDigits.length === numStr.length;
    }

    phones.forEach((phone) => {
        if (hasUniqueDigits(phone)) {
            result.push(phone);
        }
    });

    return result;
}

// Exemplo de uso da função com uma lista de números de telefone
const phoneList = db.phones.find({});
const numbersWithUniqueDigits = digitosNaoRepetidos(phoneList);

print("Números com dígitos não repetidos:", numbersWithUniqueDigits);
