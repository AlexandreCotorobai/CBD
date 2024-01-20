capicua = function (phones) {
    const result = [];
  
    phones.forEach((phone) => {
      const n = phone.display.split("-")[1];
      const inverted = n.split("").reverse().join("");
  
      if (n == inverted) {
        result.push(phone);
      }
    });
  
    return result;
  };
  
  capicua(db.phones.find({}))