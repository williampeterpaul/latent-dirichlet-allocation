for (i in 1:topics ) {
  saved = data[which(data$topic == i),]
  #saved = saved[which(saved$time > "2018-04-10" & saved$time < "2018-04-17"),]

  freq.day = tail(data.frame(table(cut(saved$time, "30 mins"))), 50)
  freq.week = tail(data.frame(table(cut(saved$time, "3.36 hours"))), 50)
  freq.month = tail(data.frame(table(cut(saved$time, "9.6 hours"))), 50)
  freq.quater = tail(data.frame(table(cut(saved$time, "58.4 hours"))), 50)

  print(ggplot(freq.day, aes(x = Var1, y = Freq, group = 1)) +
          ggtitle(paste("Day/10 mins - topic", i)) +
          geom_line(size = 1) +
          labs(x = "Time", y = "Freq") +
          theme(axis.text.x = element_text(angle = 60, hjust = 1)))

  print(ggplot(freq.week, aes(x = Var1, y = Freq, group = 1)) +
          ggtitle(paste("Week/1 hour - topic", i)) +
          geom_line(size = 1) +
          labs(x = "Time", y = "Freq") +
          theme(axis.text.x = element_text(angle = 60, hjust = 1)))

  print(ggplot(freq.month, aes(x = Var1, y = Freq, group = 1)) +
          ggtitle(paste("Month/1 day - topic", i)) +
          geom_line(size = 1) +
          labs(x = "Time", y = "Freq") +
          theme(axis.text.x = element_text(angle = 60, hjust = 1)))

  print(ggplot(freq.quater, aes(x = Var1, y = Freq, group = 1)) +
          ggtitle(paste("Quater/3 day - topic", i)) +
          geom_line(size = 1) +
          labs(x = "Time", y = "Freq") +
          theme(axis.text.x = element_text(angle = 60, hjust = 1)))
}
