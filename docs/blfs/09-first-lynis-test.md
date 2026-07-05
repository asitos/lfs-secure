after installing and configuring the recommended packages from the blfs book, and understanding how they work by going through their documentations, i tried to implement those in my system. 

then, ran my first lynis audit test on it
the following grep + sed cmds were used to generate the audits:

```
$(grep "Warning" /var/log/lynis.log | sed 's/.*Warning//g')
$(grep "Suggestion" /var/log/lynis.log | sed 's/.*Suggestion//g')

$(grep hardening_index /var/log/lynis-report.dat)
```

hardening_index=65

not bad for the first audit, need to make this cross 85+
