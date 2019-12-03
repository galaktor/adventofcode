//usr/bin/env go run $0 "$@"; exit
package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
	"sync"
)

type Point struct {
	X     int
	Y     int
	Steps int
}

func (p *Point) Copy() Point {
	return Point{p.X, p.Y, 0}
}

func (p *Point) Update(dir string, len int) {
	switch strings.ToLower(dir) {
	case "u":
		p.Y = p.Y + len
	case "d":
		p.Y = p.Y - len
	case "l":
		p.X = p.X - len
	case "r":
		p.X = p.X + len
	default:
		panic("unknown direction: " + dir)
	}
	p.Steps = p.Steps + len
	return
}

func (p *Point) Distance() int {
	return int(math.Abs(float64(p.X)) + math.Abs(float64(p.Y)))
}

func (p *Point) String() string {
	return fmt.Sprintf("%d:%d[%d,%d]", p.X, p.Y, p.Distance(), p.Steps)
}

func (p *Point) Equal(other Point) bool {
	return p.X == other.X && p.Y == other.Y
}

type Wire struct {
	Points []Point
}

func NewWire(steps []string) Wire {
	w := Wire{Points: []Point{Point{X: 0, Y: 0}}}
	for _, s := range steps {
		w.Interpolate(s)
	}
	return w
}

func (w *Wire) Jump(step string) {
	dir := strings.ToLower(string(step[0]))
	l, _ := strconv.Atoi(step[1:])
	p := w.Points[len(w.Points)-1]
	p.Update(dir, l)
	w.Points = append(w.Points, p)
	return
}

func (w *Wire) Interpolate(step string) {
	dir := strings.ToLower(string(step[0]))
	l, _ := strconv.Atoi(step[1:])
	for i := 0; i < l; i++ {
		w.Jump(dir + "1")
	}
	return
}

func (w *Wire) String() (res string) {
	tmp := []string{}
	for _, p := range w.Points[1:] {
		tmp = append(tmp, p.String())
	}
	return strings.Join(tmp, "->")
}

func main() {
	println("hi")

	file, _ := os.Open(os.Args[1])
	defer file.Close()
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)
	var txtlines []string
	for scanner.Scan() {
		txtlines = append(txtlines, scanner.Text())
	}
	var wires []*Wire
	for _, line := range txtlines {
		w := NewWire(strings.Split(line, ","))
		// fmt.Printf("%v\n", w)
		wires = append(wires, &w)
	}
	wire1 := wires[0]
	wire2 := wires[1]

	var lowest int
	dist := make(chan int)

	go func() {
		for {
			if new := <-dist; lowest == 0 || new < lowest {
				lowest = new
				fmt.Printf("new lowest: %d\n", lowest)
			}
		}
	}()

	var wg sync.WaitGroup
	for _, p2 := range wire2.Points[1:] {
		for _, p1 := range wire1.Points[1:] {
			wg.Add(1)
			go func(p1 Point, p2 Point) {
				defer wg.Done()
				if p1.Equal(p2) {
					dist <- p1.Steps + p2.Steps
					fmt.Printf("intersect: %s\n", p1.String())
				}
			}(p1, p2)
		}
	}
	wg.Wait()

	fmt.Printf("lowest steps: %v\n", lowest)

	//	puts wire2.points.drop(1).select{ |p2| wire1.points.drop(1).any?{ |p1| p1.equal(p2) }}.map{ |p| p.distance }.sort.first
}
