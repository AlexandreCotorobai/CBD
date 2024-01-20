prefixCount = function () {
    return db.phones.aggregate([
        {
            $group: {
                _id: "$components.prefix",
                count: { $sum: 1 }
            }
        },
        {
            $sort: { _id: 1 }
        }	
    ]);
}

//
//RESULTS
//

// [
//     {
//         "_id" : 21.0,
//         "count" : 33520.0
//     },
//     {
//         "_id" : 22.0,
//         "count" : 33035.0
//     },
//     {
//         "_id" : 231.0,
//         "count" : 33502.0
//     },
//     {
//         "_id" : 232.0,
//         "count" : 33326.0
//     },
//     {
//         "_id" : 233.0,
//         "count" : 33361.0
//     },
//     {
//         "_id" : 234.0,
//         "count" : 33256.0
//     }
// ]