var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
//app.use(express.static(path.join(__dirname, 'js'))); //don't do this or it'll be root of website-- use "/javascripts" to access public/javascripts instead
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;

// Default input: text box
// TODO: annotate child tables that use value
// TODO: Default Caption: remove anything before first underscore, replace underscores with spaces
// TODO: if using a NoSQL db, don't save false booleans nor empty strings
fun.defineTable("ActivitiesTypes", [
  {name:'AT_Id', type:'integer', generated:true},
  {name:'WPT_Id', type:'integer', caption:'Required Permission', sourceTable:'WorkPermissionsTypes'},
  {name:'PP_Id', type:'integer', caption:'Phase'},
  {name:'AT_ShowOnDay', default:false},
  {name:'AT_ShowOnDayAs', inputType:'memo', caption:'Description', required:true},
  {name:'AT_ShowOnWeekAs'},
  {name:'AT_Bold', type:'boolean', inputType:'checkbox', default:false},
  {name:'AT_Italics', type:'boolean', inputType:'checkbox', default:false},
  {name:'AT_FGColor', type:'string', inputType:'colorpicker'},
  {name:'AT_BGColor', type:'string', inputType:'colorpicker'},
  {name:'AT_TimeOnWeekAs', type:'string', caption:"Time Format on Weekly"},
  {name:'AT_TimeColor', type:'string', inputType:'colorPicker'},
  {name:'AT_LimitPerWeek', type:'integer'},
  {name:'AT_FractionOfDay', type:'float', required:true, default:0.5},
  {name:'AT_Available', type:'boolean', inputType:'checkbox', default:true},
  {name:'SIR_Id', type:'integer', sourceTable:'ScheduleItemsReasons', required:false, tip:'Only define this if you want to pre-fill the reason!'},
]);

fun.defineTable("PeoplePhases", [
  {name:'PP_Id', type:'integer'},
]);

fun.defineTable("People", [
  {name:'P_Id', generated:true},
  {name:'P_LastName'},
  {name:'P_FirstName'},
  {name:'P_MiddleName'},
  {name:'PP_Id', sourceTable:'PeoplePhases', required:true, default:1},
  {name:'PP_Active', default:1, inputType:'checkbox'},
  {name:'PP_Note'},
]);


// TODO: implement values list values:[{'1':'13:00'},{'2':'14:00'}]

//sourceTable is commented since context prefills value
fun.defineTable("ScheduleItems", [
  {name:'SI_Id', generated:true},
  {name:'P_Id', required:true}, //sourceTable:'People'
  {name:'W_Id', required:true}, //sourceTable:'Weeks'
  {name:'WSC_Id', required:true}, //sourceTable:'WeekScheduleColumns'
  {name:'AT_Id', type:'integer', sourceTable:'ActivitiesTypes', required:true},
  {name:'SI_Time', type:'time', inputType:'timePicker', caption:'Time (HH:MM)'},
  {name:'SI_ShowOnWkAs'},
  {name:'SIR_Id', sourceTable:'ScheduleItemsReasons', caption: "Reason ID"},
]);