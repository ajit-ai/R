# Dates and Times in R
# ============================================================

cat("--- 1. Date class ---\n")
today <- Sys.Date()
print(today)
print(class(today))
print(as.numeric(today)) # days since 1970-01-01

d1 <- as.Date("2024-01-15")
d2 <- as.Date("2024/02/20", format = "%Y/%m/%d")
d3 <- as.Date("15-01-2024", format = "%d-%m-%Y")
print(d1); print(d2); print(d3)
print(d2 - d1) # difference in days

# Sequence of dates
print(seq(as.Date("2024-01-01"), as.Date("2024-01-10"), by = "day"))
print(seq(as.Date("2024-01-01"), by = "month", length.out = 6))

cat("\n--- 2. POSIXct and POSIXlt ---\n")
now_ct <- Sys.time()
print(now_ct)
print(class(now_ct)) # POSIXct

now_lt <- as.POSIXlt(Sys.time())
print(now_lt)
print(class(now_lt))
print(now_lt$hour); print(now_lt$min); print(now_lt$sec)
print(now_lt$wday); print(now_lt$yday); print(now_lt$mon)

# Parsing datetime
dt1 <- as.POSIXct("2024-01-15 14:30:00", format = "%Y-%m-%d %H:%M:%S")
print(dt1)
dt2 <- as.POSIXct("15/01/2024 02:30 PM", format = "%d/%m/%Y %I:%M %p")
print(dt2)

cat("\n--- 3. Formatting ---\n")
print(format(Sys.Date(), "%d %B %Y"))         # 15 January 2024
print(format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
print(format(Sys.time(), "%A, %d %B %Y %I:%M %p"))

# Format codes: %Y year 4-digit, %m month, %d day, %H hour 24h, %I 12h,
# %M minute, %S second, %A weekday full, %a abbr, %B month full, %b abbr, %p AM/PM

cat("\n--- 4. difftime ---\n")
start <- as.POSIXct("2024-01-01 09:00:00")
end <- as.POSIXct("2024-01-01 17:30:00")
print(difftime(end, start, units = "hours"))
print(difftime(end, start, units = "mins"))
print(difftime(end, start, units = "secs"))
print(difftime(end, start, units = "days"))
print(difftime(Sys.Date(), as.Date("2020-01-01"), units = "days"))

cat("\n--- 5. Arithmetic with dates ---\n")
print(Sys.Date() + 1)          # tomorrow
print(Sys.Date() - 7)          # last week
print(Sys.Date() + 30)
print(Sys.time() + 3600)       # +1 hour (seconds)

# Months/years via seq
print(seq(Sys.Date(), by = "1 month", length.out = 5))
print(seq(Sys.Date(), by = "1 year", length.out = 3))

cat("\n--- 6. Weekdays, months, quarters ---\n")
print(weekdays(Sys.Date()))
print(months(Sys.Date()))
print(quarters(Sys.Date()))
print(julian(Sys.Date())) # days since origin

cat("\n--- 7. lubridate (if available) ---\n")
if (requireNamespace("lubridate", quietly = TRUE)) {
  library(lubridate)
  print(ymd("20240115"))
  print(mdy("01-15-2024"))
  print(dmy("15/01/2024"))
  print(ymd_hms("2024-01-15 14:30:00"))
  print(year(Sys.Date())); print(month(Sys.Date())); print(day(Sys.Date()))
  print(wday(Sys.Date(), label = TRUE))
  print(interval(ymd("2024-01-01"), ymd("2024-12-31")))
  print(duration(days = 10))
  print(Sys.Date() + days(5))
  print(Sys.Date() + months(2))
} else {
  message("lubridate not installed - install.packages('lubridate')")
  # Base R alternatives shown above work without lubridate
}

cat("\n--- 8. Time zones ---\n")
print(Sys.timezone())
print(as.POSIXct("2024-01-15 12:00:00", tz = "UTC"))
print(as.POSIXct("2024-01-15 12:00:00", tz = "America/New_York"))
print(as.POSIXct("2024-01-15 12:00:00", tz = "Asia/Kolkata"))
print(format(Sys.time(), tz = "UTC", usetz = TRUE))

cat("\n--- 9. strptime ---\n")
print(strptime("2024-01-15 14:30:00", "%Y-%m-%d %H:%M:%S"))
print(class(strptime("2024-01-15", "%Y-%m-%d")))

cat("\n--- 10. Practical: age calculation ---\n")
birth <- as.Date("1995-06-15")
today <- Sys.Date()
age_days <- as.numeric(difftime(today, birth, units = "days"))
age_years <- floor(age_days / 365.25)
print(paste("Age:", age_years, "years (", age_days, "days)"))

# Business days (exclude weekends)
all_days <- seq(as.Date("2024-01-01"), as.Date("2024-01-31"), by = "day")
weekdays_num <- as.POSIXlt(all_days)$wday
business_days <- all_days[!weekdays_num %in% c(0, 6)] # 0=Sunday, 6=Saturday
print(business_days)
print(length(business_days))

cat("\n--- Done: Dates and Times ---\n")
