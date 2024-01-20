
function findSequence(sequence, phones){
    const result = [];
    
    phones.forEach((phone) =>{
        const number = phone.display.split("-")[1];
        if(number.includes(sequence)){
            result.push(phone)
        }
    })
    return result;
  }
  
  findSequence("000002", db.phones.find({}))