### -*- mode: r; mode: outline-minor -*-
### inverse-sample.r --- Samples the inverse probability distribution of the samples on the lines of input

#* Preable
## Copyright (C) 2010  Michael Zeller

## Author: Michael Zeller <michael.zeller@uci.edu>
## Keywords: 

## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

#* Commentary

## 

#* Code

data <- read.table("/dev/stdin", header=F, sep="\n", quote="")
f <- factor(data[,1])
counts <- tabulate(f)
lf <- levels(f)
write(lf[sample(length(lf), 1, prob=1/counts)], file="/dev/stdout")

### inverse-sample.r ends here
