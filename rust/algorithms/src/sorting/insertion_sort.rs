/**
 * Chapter 02 - Insertion Sort
 */
pub fn insertion_sort(arr: &mut Vec<i32>) {
    for i in 1..arr.len() {
        let key = arr[i];

        let mut j = i - 1;
        let mut swap = true;

        while arr[j] > key {
            arr[j + 1] = arr[j];
            if j == 0 {
                // since j cannot go negative (type usize), swap now and set flag to false
                arr[0] = key;
                swap = false;
                break;
            }

            j = j - 1;
        }

        if swap {
            arr[j + 1] = key;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    use rand::seq::SliceRandom;
    use rand::thread_rng;

    #[test]
    pub fn test_sort_basic() {
        let mut input = vec![2, 1];
        insertion_sort(&mut input);
        assert_eq!(vec![1, 2], input);
    }

    #[test]
    pub fn test_single_element() {
        let mut input = vec![1];
        insertion_sort(&mut input);
        assert_eq!(vec![1], input);
    }

    #[test]
    pub fn test_already_sorted() {
        for i in 1..=10 {
            let mut arr = (1..=i).collect();
            test_sorted(&mut arr);
        }
    }

    #[test]
    pub fn test_reverse_sorted() {
        for i in 1..=10 {
            let mut arr: Vec<i32> = (1..=i).collect();
            arr.reverse();
            test_sorted(&mut arr);
        }
    }

    #[test]
    pub fn test_shuffled_sorted() {
        for i in 1..=100 {
            let mut arr: Vec<i32> = (1..=i).step_by(10).collect();
            arr.shuffle(&mut thread_rng());
            test_sorted(&mut arr);
        }
    }

    fn test_sorted(arr: &mut Vec<i32>) {
        let orig = arr.clone();
        let mut clone = arr.clone();

        insertion_sort(arr);

        clone.sort();

        assert_eq!(
            &clone, arr,
            "failed to sort array: {orig:?}. Sorted output is {arr:?}"
        );
    }
}
