


var timePickerData = [['7 AM','07:00'],['8 AM','08:00'],['9 AM','09:00'],['10 AM','10:00'],['11 AM','11:00'],['12 PM','12:00'],['1 PM','13:00'],['2 PM','14:00'],['3 PM','15:00'],['4 PM','16:00'],['5 PM','17:OO'],['6 PM','18:00']];

function generateDropDownFromPairs(table, nameStr, idStr, classStr) {
    var ret = "";
    var inLength = pairs.length;
    for (var i = 0; i < inLength; i++) {
        var caption = table[i][nameStr];
        ret += "\n        <option value=\""+table[i][nameStr]+'">'+caption+'</option>'
    }
    if (ret.length > 0) {
        var propertiesStr = "";
        if (typeof classStr !== 'undefined')
            propertiesStr += ' class="'+classStr+'"';
        if (typeof idStr !== 'undefined')
            propertiesStr += ' id="'+idStr+'"';
        if (typeof nameStr !== 'undefined')
            propertiesStr += ' name="'+nameStr+'"';
        
        ret = "\n      <select"+propertiesStr+">\n" + ret + "\n      </select>\n";
    }
    return ret;
}

// TODO: maxLength
function generateDropDownFromPairs(pairs, nameStr, idStr, classStr) {
    var ret = "";
    var inLength = pairs.length;
    for (var i = 0; i < inLength; i++) {
        ret += "\n        <option value=\""+pairs[i][1]+'">'+pairs[i][0]+'</option>'
    }
    if (ret.length > 0) {
        var propertiesStr = "";
        if (typeof classStr !== 'undefined')
            propertiesStr += ' class="'+classStr+'"';
        if (typeof idStr !== 'undefined')
            propertiesStr += ' id="'+idStr+'"';
        if (typeof nameStr !== 'undefined')
            propertiesStr += ' name="'+nameStr+'"';
        
        ret = "\n      <select"+propertiesStr+">\n" + ret + "\n      </select>\n";
    }
    return ret;
}

function generateForm(formSpec, tables) {
    var ret = '<form action="/" method="get">';
    var inLength = formSpec.length;
    for (var i = 0; i < inLength; i++) {
        
        var field = formSpec[i];
        var caption = field.name;
        var fromTable = false;
        var fieldHtml = "";
        if (typeof field.sourceTable !== 'undefined') {
            fromTable = true;
        }
        if (typeof field.caption !== 'undefined') {
            caption = field.caption;
        }
        else {
            if (!fromTable) {
                caption = caption.substring(caption.indexOf("_") + 1);
            }
            caption = caption.replace("_", " ");
        }
        if (fromTable) {
            if (typeof tables[field.sourceTable] === 'object') {
                fieldHtml = generateDropDown(tables[field.sourceTable], field.name, field.name, "form-control");
                if (fieldHtml.length > 0) {
                    fieldHtml = "\n    "+'<div class="form-group">'
                        +"\n      "+'<label for="'+field.name+'">'+caption+'</label>';
                        + fieldHtml
                        +"\n    "+'</div>';
                }
            }
        }
        if (fieldHtml.length > 0) {
            ret += fieldHtml;
        }
        else if (field.inputType == 'timePicker') {
            ret += "\n    "+'<div class="form-group">'
                 + "\n      "+'<label for="'+field.name+'">'+caption+'</label>';
                 + generateDropDownFromPairs(timePickerData, field.name, field.name, "form-control");
                 + "\n    "+'</div>';
        }
        else if (field.inputType == 'checkbox') {
            ret += "\n    "+'<div class="form-group form-check">'
                    + "\n      "+'<input type="checkbox" class="form-check-input" name="'+field.name+'" id="'+field.name+'">'
                    + "\n      "+'<label class="form-check-label" for="'+field.name+'">'+caption+'</label>'
                    + "\n    "+'</div>';
        }
        else if (field.inputType == 'textarea' || field.inputType == 'memo') {
            // ret += '<textarea name="'+field.name+'" rows="4" cols="50"></textarea>';
            ret += "\n    "+'<div class="form-group">'
                    + "\n      "+'<label for="'+field.name+'">Example textarea</label>'
                    + "\n      "+'<textarea class="form-control" name="'+field.name+'" id="'+field.name+'" rows="3"></textarea>'
                    + "\n    "+'</div>';
        }
        else {
            ret += "\n" + '<input name="'+field.name+'" id="'+field.name+'" class="form-control" type="text" placeholder="'+caption+'">';
        }
    }
    ret += '<button type="submit" class="btn btn-primary">Submit</button>';
    ret += "\n</form>";
    return ret;
}