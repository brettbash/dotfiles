#!/usr/bin/env python3
from extensioncore import *
import datetime
from zoneinfo import ZoneInfo

PRINCIPAL_TAG='work'

def calculate_principal_hours_day(configuration, timeEntries):
    timePerDay = {}
    timePerPrincipal = {}
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
        if PRINCIPAL_TAG in entry['tags']:
            if dateKey in timePerPrincipal:
                timePerPrincipal[dateKey] = timePerPrincipal[dateKey] + spentTime.seconds
            else:
                timePerPrincipal[dateKey] = spentTime.seconds

    totalTime = 0
    for date, secondsTotal in timePerDay.items():
        totalTime = timePerDay[date]
        if date in timePerPrincipal:
            principalTime = timePerPrincipal[date]
        else:
            principalTime = 0
        totalTime = totalTime + principalTime
        totalTimeConverted = seconds_to_hms(totalTime)
        print(f'{totalTimeConverted[0]:02}:{totalTimeConverted[1]:02}:{totalTimeConverted[2]:02}')

if __name__ == "__main__":
    configuration, timeEntries = parse_from_stdin()
    if len(timeEntries) > 0:
        calculate_principal_hours_day(configuration,timeEntries)
    else:
        print(f'χαῖρε Σατανά')
