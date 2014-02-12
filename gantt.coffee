###
Gantt 每行都有固定高度
Gantt 右边应该有个最大的textlength
Gantt 表示日期的在下面，从0开始
Gantt 最小时间单位以周为单位
Gantt 最长周数不会超过2位数
Gantt 最大任务数有限制
###

Gantt = (data, config, ctx) ->
  limit =
    maxWeeks: 99
    maxTasks: 10

  #scale bound
  scaleHeight = height - config.scaleFontSize - 5
  scaleWidth = width - config.maxTaskNameLength - 5

  config =
    maxTaskNameLength: 20

  today = new Date()
  startDay = new Date data.start
  diff = (today - startDay) / (7 * 24 * 3600 * 1000)

  drawGanttTasks = (animationDecimal) ->
    todayPosX = 0
    if diff < data.totalWeeks
      todayPosX = width - scaleWidth + diff / data.totalWeeks * animationDecimal * (scaleWidth - 5)

    step = 20
    ctx.lineCap = "round"
    ctx.lineWidth = config.taskLineWidth
    ctx.strokeStyle = config.taskLineColor
    for task, i in data.tasks
      ctx.beginPath()
      from = width - scaleWidth + task.from / data.totalWeeks * (scaleWidth - 5)
      to = width - scaleWidth + (task.from + (task.to - task.from) * animationDecimal) / data.totalWeeks * (scaleWidth - 5)
      if from < todayPosX < to
        ctx.strokeStyle = "rgb(255,0,0)"
        ctx.beginPath()
        ctx.moveTo from, step * i + 5
        ctx.lineTo todayPosX, step * i + 5
        ctx.stroke()
        ctx.strokeStyle = config.taskLineColor
        ctx.moveTo todayPosX, step * i + 5
        ctx.lineTo to, step * i + 5
        ctx.stroke()
      else
        ctx.strokeStyle = if from >= todayPosX then config.taskLineColor else "rgb(255,0,0)" 
        ctx.beginPath()
        ctx.moveTo from, step * i + 5
        ctx.lineTo to, step * i + 5
        ctx.stroke()

    if todayPosX > 0
      ctx.lineWidth = config.scaleWeekLineWidth
      ctx.strokeStyle = "rgba(255,0,0,.4)"
      ctx.beginPath()
      ctx.moveTo todayPosX, 0
      ctx.lineTo todayPosX, scaleHeight
      ctx.stroke()

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
    step = (scaleWidth - 5) / data.totalWeeks
    ctx.textAlign = "right"
    ctx.fillText data.start, width - scaleWith, scaleHeight + config.scaleFontSize
    for i in [1..data.totalWeeks]
      posX = width - scaleWidth + step * i

      ctx.beginPath()
      ctx.moveTo posX, 0
      ctx.lineTo posX, scaleHeight
      ctx.stroke()

      ctx.fillText "#{i}", posX, scaleHeight + config.scaleFontSize

    #draw tasks'name
    ctx.font = "#{ctx.scaleFontStyle} #{ctx.scaleTaskFontSize}px #{ctx.scaleFontFamily}"
    ctx.fillStyle = ctx.scaleTaskFontColor
    step = config.scaleTaskFontSize + 20
    for task, i in data.tasks
      ctx.fillText task.name, width - scaleWidth - 5, step * i + config.scaleTaskFontSize + 5
    ctx.font = "#{ctx.scaleFontStyle} #{ctx.scaleFontSize}px #{ctx.scaleFontFamily}"

    null

  null

