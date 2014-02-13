Gantt = (data, config, ctx) ->
  #scale bound
  maxLabelLength = 0
  for task in data.tasks
    taskLabelLength = ctx.measureText task.name 
    maxLabelLength = taskLabelLength if taskLabelLength > maxLabelLength
  maxLabelLength = config.maxTaskNameLength if maxLabelLength > config.maxTaskNameLength
  maxLabelLength = config.minTaskNameLength if maxLabelLength < config.minTaskNameLength
  scaleHeight = height - config.scaleFontSize - 5
  scaleWidth = width - maxLabelLength - 5
  step = config.scaleTaskFontSize + 5

  today = new Date()
  startDay = new Date data.start
  diff = (today - startDay) / (7 * 24 * 3600 * 1000)

  drawGanttTasks = (animationDecimal) ->
    todayPosX = 0
    if diff < data.totalWeeks
      todayPosX = width - scaleWidth + diff / data.totalWeeks * animationDecimal * (scaleWidth - 5)

    ctx.lineCap = "round"
    ctx.lineWidth = config.taskLineWidth
    ctx.strokeStyle = config.taskLineColor
    for task, i in data.tasks
      from = width - scaleWidth + task.from / data.totalWeeks * (scaleWidth - 5)
      to = width - scaleWidth + (task.from + (task.to - task.from) * animationDecimal) / data.totalWeeks * (scaleWidth - 5)
      if from < todayPosX < to
        ctx.strokeStyle = config.taskFinishLineColor
        ctx.beginPath()
        ctx.moveTo from, step * i + config.scaleFontSize * 3 / 2
        ctx.lineTo todayPosX, step * i + config.scaleFontSize * 3 / 2
        ctx.stroke()
        ctx.strokeStyle = config.taskLineColor
        ctx.beginPath()
        ctx.moveTo todayPosX, step * i + config.scaleFontSize * 3 / 2
        ctx.lineTo to, step * i + config.scaleFontSize * 3 / 2
        ctx.stroke()
      else
        ctx.strokeStyle = if from >= todayPosX then config.taskLineColor else config.taskFinishLineColor
        ctx.beginPath()
        ctx.moveTo from, step * i + config.scaleFontSize * 3 / 2
        ctx.lineTo to, step * i + config.scaleFontSize * 3 / 2
        ctx.stroke()

    if todayPosX > 0
      ctx.lineWidth = config.taskTodayLineWidth
      ctx.strokeStyle =  config.taskFinishLineColor
      ctx.beginPath()
      ctx.moveTo todayPosX, 0
      ctx.lineTo todayPosX, scaleHeight
      ctx.stroke()
      
      if config.taskShowToday
        ctx.textAlign = "center"
        ctx.font = "#{config.scaleFontStyle} #{config.scaleFontSize}px #{config.scaleFontFamily}"
        ctx.textBaseline = "top"

        ctx.fillStyle = config.scaleFontColor
        ctx.fillText "Today", todayPosX, 0

    null

  drawScale = () ->
    #draw x axis
    ctx.lineWidth = config.scaleLineWidth
    ctx.strokeStyle = config.scaleLineColor
    ctx.beginPath()
    ctx.moveTo width, scaleHeight
    ctx.lineTo width - scaleWidth, scaleHeight
    ctx.stroke()

    #draw y axis
    ctx.lineWidth = config.scaleWeekLineWidth
    ctx.strokeStyle = config.scaleWeekLineColor
    ctx.beginPath()
    ctx.moveTo width - scaleWidth, 0
    ctx.lineTo width - scaleWidth, scaleHeight
    ctx.stroke()
    #draw week bounce
    step1 = (scaleWidth - 5) / data.totalWeeks
    ctx.textAlign = "right"
    ctx.textBaseline = "top"
    ctx.fillText data.start, width - scaleWidth, scaleHeight + 5
    for i in [1..data.totalWeeks]
      posX = width - scaleWidth + step1 * i + 5

      ctx.beginPath()
      ctx.moveTo posX, 0
      ctx.lineTo posX, scaleHeight
      ctx.stroke()

      ctx.fillText "#{i}", posX, scaleHeight + 5 

    #draw tasks'name
    ctx.font = "#{config.scaleFontStyle} #{config.scaleTaskFontSize}px #{config.scaleFontFamily}"
    ctx.fillStyle = config.scaleTaskFontColor
    ctx.textBaseline = "middle"
    for task, i in data.tasks
      ctx.fillText task.name, width - scaleWidth - 5, step * i + config.scaleFontSize * 3 / 2
    ctx.font = "#{config.scaleFontStyle} #{config.scaleFontSize}px #{config.scaleFontFamily}"

    null

  null

