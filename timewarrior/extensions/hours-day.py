#!/usr/bin/env python3
from extensioncore import *
import datetime

WORK_HOURS = 8
DAYS_OFF = {5,6}

def calculate_hours_day(configuration, timeEntries):
    timePerDay = {}
    for entry in timeEntries:
        startDate = datetime.datetime.fromisoformat(entry['start'])
        if 'end' not in entry or entry['end'] is None:
            endDate = datetime.datetime.now().astimezone()
        else:
            endDate = datetime.datetime.fromisoformat(entry['end'])
        spentTime = endDate - startDate
        dateKey = str(startDate)[:10]
        if dateKey in timePerDay:
            timePerDay[dateKey] = timePerDay[dateKey] + spentTime.seconds
        else:
            timePerDay[dateKey] = spentTime.seconds
    totalTime = 0
    totalOvertime = 0
    totalUndertime = 0
    for date, secondsTotal in timePerDay.items():
        totalTime = totalTime + secondsTotal
        is_day_off = datetime.datetime.strptime(date, '%Y-%m-%d').weekday() in DAYS_OFF
        hoursSpent, minutesSpent, secondsSpent = seconds_to_hms(secondsTotal) 
        output = f'{date} - {hoursSpent:02}h {minutesSpent:02}m {secondsSpent:02}s'
        if is_day_off:
            #Always consider a day off as over time
            totalOvertime = totalOvertime + hoursSpent * SECONDS_TO_HOURS + minutesSpent * 60 + secondsSpent
            output = f'{output} - {hoursSpent:02}h {minutesSpent:02}m {secondsSpent:02}s DAY OFF'
        if hoursSpent > WORK_HOURS or (hoursSpent >= WORK_HOURS and (minutesSpent > 0 or secondsSpent > 0)):
            overtimeHours = hoursSpent - WORK_HOURS
            totalOvertime = totalOvertime + overtimeHours * SECONDS_TO_HOURS + minutesSpent * 60 + secondsSpent
            output = f'{output} - {overtimeHours:02}h {minutesSpent:02}m {secondsSpent:02}s OVER'
        elif hoursSpent < WORK_HOURS and not is_day_off:
            undertime = WORK_HOURS * SECONDS_TO_HOURS - secondsTotal
            totalUndertime = totalUndertime + undertime
            undertimeHours, undertimeMinutes, undertimeSeconds = seconds_to_hms(undertime)
            output = f'{output} - {undertimeHours:02}h {undertimeMinutes:02}m {undertimeSeconds:02}s UNDER'
        print(output)
    totalTimeConverted = seconds_to_hms(totalTime)
    totalOvertimeConverted = seconds_to_hms(totalOvertime)
    totalUndertimeConverted = seconds_to_hms(totalUndertime)
    print(f'Total days: {len(timePerDay.keys())}')
    print(f'Total time: {totalTimeConverted[0]}h {totalTimeConverted[1]}m {totalTimeConverted[2]}s')
    print(f'Total overtime: {totalOvertimeConverted[0]}h {totalOvertimeConverted[1]}m {totalOvertimeConverted[2]}s')
    print(f'Total undertime: {totalUndertimeConverted[0]}h {totalUndertimeConverted[1]}m {totalUndertimeConverted[2]}s')
    if totalOvertime >= totalUndertime:
        actualOvertime = totalOvertime - totalUndertime
        actualOvertimeConverted = seconds_to_hms(actualOvertime)
        print(f'Actual overtime: {actualOvertimeConverted[0]}h {actualOvertimeConverted[1]}m {actualOvertimeConverted[2]}s')

if __name__ == "__main__":
    configuration, timeEntries = parse_from_stdin()
    if len(timeEntries) > 0:
        calculate_hours_day(configuration,timeEntries)
    else:
        print_no_data_message(configuration)
