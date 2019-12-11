//usr/bin/env go run $0 "$@"; exit
package main

import (
	"crypto/md5"
	"fmt"
	"io"
	"strings"
	"sync"
)

func main() {
	matches := make(chan int)

	go func() {
		for {
			println(<-matches)
		}
	}()

	var wg sync.WaitGroup
	for i := 0; i <= 9999999; i += 1 {
		wg.Add(1)
		go func(i int) {
			defer wg.Done()
			h := md5.New()
			io.WriteString(h, fmt.Sprintf("yzbqklnj%06d", i))
			candidate := fmt.Sprintf("%x", h.Sum(nil))
			if strings.HasPrefix(candidate, "000000") {
				matches <- i
			}
		}(i)
	}

	wg.Wait()
}
