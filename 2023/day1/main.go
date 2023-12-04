package main

import (
  "fmt"
  "os"
  "log"
  "bufio"
  "strings"
)

func main() {

  in_file := os.Args[1]
  fmt.Println(in_file)
  file, err := os.Open(in_file)
  if err != nil {
    log.Fatal(err)
  }
  defer file.Close()

  scanner := bufio.NewScanner(file)
  for scanner.Scan() {
    line := scanner.Text()
    fmt.Println(line[strings.IndexAny(line, "0123456789")])
    //fmt.Println(line[strings.LastIndexAny(line, "0123456789")])
  }

  if err := scanner.Err(); err != nil {
    log.Fatal(err)
  }
}
