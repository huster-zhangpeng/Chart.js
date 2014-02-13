// Generated by CoffeeScript 1.6.3
(function() {
  var Gantt;

  Gantt = function(data, config, ctx) {
    var diff, drawGanttTasks, drawScale, maxLabelLength, scaleHeight, scaleWidth, startDay, step, task, taskLabelLength, today, _i, _len, _ref;
    maxLabelLength = 0;
    _ref = data.tasks;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      task = _ref[_i];
      taskLabelLength = ctx.measureText(task.name);
      if (taskLabelLength > maxLabelLength) {
        maxLabelLength = taskLabelLength;
      }
    }
    if (maxLabelLength > config.maxTaskNameLength) {
      maxLabelLength = config.maxTaskNameLength;
    }
    if (maxLabelLength < config.minTaskNameLength) {
      maxLabelLength = config.minTaskNameLength;
    }
    scaleHeight = height - config.scaleFontSize - 5;
    scaleWidth = width - maxLabelLength - 5;
    step = config.scaleTaskFontSize + 5;
    today = new Date();
    startDay = new Date(data.start);
    diff = (today - startDay) / (7 * 24 * 3600 * 1000);
    drawGanttTasks = function(animationDecimal) {
      var from, i, to, todayPosX, _j, _len1, _ref1;
      todayPosX = 0;
      if (diff < data.totalWeeks) {
        todayPosX = width - scaleWidth + diff / data.totalWeeks * animationDecimal * (scaleWidth - 5);
      }
      ctx.lineCap = "round";
      ctx.lineWidth = config.taskLineWidth;
      ctx.strokeStyle = config.taskLineColor;
      _ref1 = data.tasks;
      for (i = _j = 0, _len1 = _ref1.length; _j < _len1; i = ++_j) {
        task = _ref1[i];
        from = width - scaleWidth + task.from / data.totalWeeks * (scaleWidth - 5);
        to = width - scaleWidth + (task.from + (task.to - task.from) * animationDecimal) / data.totalWeeks * (scaleWidth - 5);
        if ((from < todayPosX && todayPosX < to)) {
          ctx.strokeStyle = config.taskFinishLineColor;
          ctx.beginPath();
          ctx.moveTo(from, step * i + config.scaleFontSize * 3 / 2);
          ctx.lineTo(todayPosX, step * i + config.scaleFontSize * 3 / 2);
          ctx.stroke();
          ctx.strokeStyle = config.taskLineColor;
          ctx.beginPath();
          ctx.moveTo(todayPosX, step * i + config.scaleFontSize * 3 / 2);
          ctx.lineTo(to, step * i + config.scaleFontSize * 3 / 2);
          ctx.stroke();
        } else {
          ctx.strokeStyle = from >= todayPosX ? config.taskLineColor : config.taskFinishLineColor;
          ctx.beginPath();
          ctx.moveTo(from, step * i + config.scaleFontSize * 3 / 2);
          ctx.lineTo(to, step * i + config.scaleFontSize * 3 / 2);
          ctx.stroke();
        }
      }
      if (todayPosX > 0) {
        ctx.lineWidth = config.taskTodayLineWidth;
        ctx.strokeStyle = config.taskFinishLineColor;
        ctx.beginPath();
        ctx.moveTo(todayPosX, 0);
        ctx.lineTo(todayPosX, scaleHeight);
        ctx.stroke();
        if (config.taskShowToday) {
          ctx.textAlign = "center";
          ctx.font = "" + config.scaleFontStyle + " " + config.scaleFontSize + "px " + config.scaleFontFamily;
          ctx.textBaseline = "top";
          ctx.fillStyle = config.scaleFontColor;
          ctx.fillText("Today", todayPosX, 0);
        }
      }
      return null;
    };
    drawScale = function() {
      var i, posX, step1, _j, _k, _len1, _ref1, _ref2;
      ctx.lineWidth = config.scaleLineWidth;
      ctx.strokeStyle = config.scaleLineColor;
      ctx.beginPath();
      ctx.moveTo(width, scaleHeight);
      ctx.lineTo(width - scaleWidth, scaleHeight);
      ctx.stroke();
      ctx.lineWidth = config.scaleWeekLineWidth;
      ctx.strokeStyle = config.scaleWeekLineColor;
      ctx.beginPath();
      ctx.moveTo(width - scaleWidth, 0);
      ctx.lineTo(width - scaleWidth, scaleHeight);
      ctx.stroke();
      step1 = (scaleWidth - 5) / data.totalWeeks;
      ctx.textAlign = "right";
      ctx.textBaseline = "top";
      ctx.fillText(data.start, width - scaleWidth, scaleHeight + 5);
      for (i = _j = 1, _ref1 = data.totalWeeks; 1 <= _ref1 ? _j <= _ref1 : _j >= _ref1; i = 1 <= _ref1 ? ++_j : --_j) {
        posX = width - scaleWidth + step1 * i + 5;
        ctx.beginPath();
        ctx.moveTo(posX, 0);
        ctx.lineTo(posX, scaleHeight);
        ctx.stroke();
        ctx.fillText("" + i, posX, scaleHeight + 5);
      }
      ctx.font = "" + config.scaleFontStyle + " " + config.scaleTaskFontSize + "px " + config.scaleFontFamily;
      ctx.fillStyle = config.scaleTaskFontColor;
      ctx.textBaseline = "middle";
      step = config.scaleTaskFontSize + 5;
      _ref2 = data.tasks;
      for (i = _k = 0, _len1 = _ref2.length; _k < _len1; i = ++_k) {
        task = _ref2[i];
        ctx.fillText(task.name, width - scaleWidth - 5, step * i + config.scaleFontSize * 3 / 2);
      }
      ctx.font = "" + config.scaleFontStyle + " " + config.scaleFontSize + "px " + config.scaleFontFamily;
      return null;
    };
    return null;
  };

}).call(this);
