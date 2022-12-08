use std::fs::File;
use std::io;
use std::io::{BufRead, BufReader};

fn total_cals_by_group() -> Vec<i64> {
    let file = File::open("../../inputs/day_1_part_1_input.txt").expect("Failed to read input");
    let buf_reader = BufReader::new(file);

    let mut groups: Vec<Vec<i64>> = vec![];
    let mut group_counter = 0;

    for maybe_line in buf_reader.lines() {
        let line = maybe_line.unwrap();

        if line.is_empty() {
            group_counter += 1;
            continue;
        }

        if let Some(group) = groups.get_mut(group_counter) {
            group.push(line.parse::<i64>().unwrap());
        } else {
            groups.push(vec![line.parse::<i64>().unwrap()]);
        }
    }

    groups
        .into_iter()
        .map(|group| group.into_iter().sum::<i64>())
        .collect()
}

fn compute_part_1() -> i64 {
    total_cals_by_group().into_iter().max().unwrap()
}

fn compute_part_2() -> i64 {
    let mut sorted_groups = total_cals_by_group();
    sorted_groups.sort();
    sorted_groups.into_iter().rev().take(3).sum()
}

fn main() -> io::Result<()> {
    println!("Part 1: {}", compute_part_1());
    println!("Part 2: {}", compute_part_2());
    Ok(())
}

#[cfg(test)]
mod tests {
    use crate::compute_part_1;
    use crate::compute_part_2;

    #[test]
    fn expected_values_returned() {
        assert_eq!(compute_part_1(), 69177);
        assert_eq!(compute_part_2(), 207456);
    }
}
