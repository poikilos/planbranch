

var dataFields = {};

exports.defineTable = function (tableName, obj) {
	dataFields[tableName] = obj;
}

var sampleData = {};

exports.getFormSpecs = function () {
	return dataFields;
}

exports.getSampleData = function () {
	return sampleData;
}

exports.pushSampleData = function (tableName, valueList) {
	sampleData[tableName] = {};
	var dstLength = dataFields[tableName].length;
	var srcLength = valueList.length;
	var fields = dataFields[tableName];
	var i;
	for (i = 0; i < dstLength; i++) {
		if (i > srcLength) {
			break;
		}
		sampleData[tableName][fields[i].name] = valueList[i];
	}
	if (i < dstLength) {
		console.error(i + " < " + tableName + ".length for: ");
		console.error("  " + valueList.join(', '));
	}
}


exports.restrict = function (req, res, next) {
	//see <http://toon.io/on-passportjs-specific-use-cases/>
	//express-specific improvements from <https://scotch.io/tutorials/route-middleware-to-check-if-a-user-is-authenticated-in-node-js>
	//if (req.isUnAuthenticated())
	return next;
	// TODO: authenticate instead:
	// if (!req.user || !req.user.username) {
	// 	//only Angular (?) return req.json(403, {message: 'Access denied, please log in'});
	// 	var results = {"error":"Access denied"};
	// 	res.send(results);
	// }
    // else return next();
}
