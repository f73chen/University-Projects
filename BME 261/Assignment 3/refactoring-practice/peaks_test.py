import pickle
import numpy as np
import pytest
from peaks import PeakTracker


@pytest.fixture
def ecg_data():
    with open('106m.pkl', 'rb') as file:
        data = pickle.load(file)
    return (data - np.mean(data))/200


def test_add_sample(ecg_data):
    n_peaks = 3
    tracker = PeakTracker(n_peaks, 4, .3)
    tracker.add_sample(ecg_data[0])
    assert sum(np.isnan(tracker.peak_times)) == n_peaks
    assert sum(np.isnan(tracker.peak_amplitudes)) == n_peaks

    # peak at sample 60 (detected at 61)
    for i in range(1, 62):
        tracker.add_sample(ecg_data[i])
    assert sum(np.isnan(tracker.peak_times)) == n_peaks - 1


def test_smoothing(ecg_data):
    tracker = PeakTracker(3, 4, .3)
    for i in range(51):
        tracker.add_sample(ecg_data[i])
    assert tracker.last_smoothed_sample == pytest.approx(0.5, .02)


def test_get_mean_amplitude(ecg_data):
    tracker = PeakTracker(3, 4, .3)
    for i in range(62):
        tracker.add_sample(ecg_data[i])
    assert tracker.get_mean_amplitude() == pytest.approx(0.753, .01)

    for i in range(70, 360):
        tracker.add_sample(ecg_data[i])
    assert tracker.get_mean_amplitude() == pytest.approx((0.753+2.0)/2, .01)


def test_get_mean_interval(ecg_data):
    tracker = PeakTracker(3, 4, .3)
    for i in range(62):
        tracker.add_sample(ecg_data[i])
    assert np.isnan(tracker.get_mean_interval())

    for i in range(62, 360):
        tracker.add_sample(ecg_data[i])
    assert tracker.get_mean_interval() == 353-60

