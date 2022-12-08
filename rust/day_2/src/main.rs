use std::collections::HashMap;
use std::fs::File;
use std::io;
use std::io::{BufRead, BufReader};

fn my_move_scores(key: &str) -> i64 {
    let data: HashMap<&str, i64> = HashMap::from([("X", 1), ("Y", 2), ("Z", 3)]);
    data[key]
}

fn outcome_scores(key: &str) -> i64 {
    // their_play, my_play
    let data: HashMap<&str, i64> = HashMap::from([
        ("A X", 3), // rock, rock
        ("A Y", 6), // rock, paper
        ("A Z", 0), // rock, scissors
        ("B X", 0), // paper, rock
        ("B Y", 3), // paper, paper
        ("B Z", 6), // paper, scissors
        ("C X", 6), // scissors, rock
        ("C Y", 0), // scissors, paper
        ("C Z", 3), // scissors, scissors
    ]);
    data[key]
}

fn winning_plays(key: &str) -> &str {
    let data: HashMap<&str, &str> = HashMap::from([
        ("A", "Y"), // rock, paper
        ("B", "Z"), // paper, scissors
        ("C", "X"), // scissors, rock
    ]);
    data[key]
}

fn drawing_plays(key: &str) -> &str {
    let data: HashMap<&str, &str> = HashMap::from([
        ("A", "X"), // rock, rock
        ("B", "Y"), // paper,  paper
        ("C", "Z"), // scissors, scissors
    ]);
    data[key]
}

fn losing_plays(key: &str) -> &str {
    let data: HashMap<&str, &str> = HashMap::from([
        ("A", "Z"), // rock, scissors
        ("B", "X"), // paper, rock
        ("C", "Y"), // scissors, paper
    ]);
    data[key]
}

fn desired_outcome_scores(key: &str) -> i64 {
    let data: HashMap<&str, i64> = HashMap::from([
        ("X", 0), // lose
        ("Y", 3), // draw
        ("Z", 6), // win
    ]);
    data[key]
}

fn part_1() -> i64 {
    let mut answer: i64 = 0;
    let file = File::open("../../inputs/day_2_part_1_input.txt").expect("Failed to open file");
    let lines = BufReader::new(file).lines().map(|l| l.unwrap());

    for line in lines {
        if let Some(my_move) = line.split_whitespace().last() {
            answer += my_move_scores(my_move) + outcome_scores(&line);
        }
    }

    answer
}

fn part_2() -> i64 {
    let mut answer: i64 = 0;
    let file = File::open("../../inputs/day_2_part_1_input.txt").expect("Failed to open file");
    let lines = BufReader::new(file).lines().map(|l| l.unwrap());

    for line in lines {
        let split = line.split_whitespace().collect::<Vec<&str>>();
        let their_move = split[0];
        let desired_outcome = split[1];

        let my_move = match desired_outcome {
            "X" => losing_plays(their_move),
            "Y" => drawing_plays(their_move),
            "Z" => winning_plays(their_move),
            _ => panic!("Bad desired_outcome"),
        };

        answer += my_move_scores(my_move) + desired_outcome_scores(desired_outcome);
    }

    answer
}
fn main() -> io::Result<()> {
    println!("Part 1: {}", part_1());
    println!("Part 2: {}", part_2());

    assert_eq!(part_1(), 12794);
    assert_eq!(part_2(), 14979);

    Ok(())
}
