# Spotify Song Pairs
# Spotify is working on a new "community radio station" feature which allows users to iteratively populate the playlist with their desired songs. Considering this radio station will also have other scheduled shows to be aired, and to make sure the community soundtrack will not run over other scheduled shows, the user-submitted songs will be organized in full-minute blocks. Users can choose any songs they want to add to the community list, but only in Paris of songs with durations that add up to a multiple of 60 seconds. (e.g. 60, 120, 180).
# As an attempt to insist on the highest standards and avoid this additional burden on users, Spotify will let them submit any number of songs they want, with any duration, and will handle this 60-second matching internally. Once the user submits their list, given a list of song durations, calculate the total number of distinct song pairs that can be chosen by Spotify. 
# Example
# -------
# N = 3
# Songs = [37, 23, 60]
# One pair of songs can be chosen who's combined duration is a multiple of a whole minute (37 + 23 = 60) and the returned value would be 1. While the third song is a single minute long, songs must be chosen in pairs. 
#  --------------------
# |Function Description| 
#  --------------------
# Complete the function getSongPairCount in the editor below.
# Get SongPairCount has the following parameter:
# Int songs[n] array of integers representing song durations in seconds. 
# Returns:
# perfectPairs: the total number of songs pairs that add up to a multiple of 60 seconds. If there are no suitable pairs, return 0.
# Example input:
# getSongPairCount([37, 23, 60])
# out: 1
# getSongPairCount([120, 60, 59, 1])
# Out: 2


def getSongPairCount(array):
    multiple = 0
    diff = 0
    d1 = {}
    for num in array:
        if num % 60 == 0:
            multiple += 1
        else:
            if num in d1:
                diff += 1
            else:
                d1[60 - num] = 1
    
    return multiple//2 + diff

print(getSongPairCount([37, 23, 60, 40, 20]))

def getSongPairCount2(song_list):
    song_pairs = 0
    sorted_songs = sorted([i % 60 for i in song_list if i % 60 != 0])
    song_pairs += (len(song_list) - len(sorted_songs)) // 2
    left = 0
    right = len(sorted_songs) -1
    
    while left < right:
        pair = sorted_songs[left] + sorted_songs[right]
        if pair % 60 == 0:
            song_pairs += 1
            left += 1
            right -= 1
        elif pair > 60:
            right -= 1
        else:
            left += 1
    return song_pairs
    
    
print(getSongPairCount([40,80]))
    