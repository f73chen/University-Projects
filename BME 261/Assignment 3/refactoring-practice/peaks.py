import numpy as np


def get_nan_mean(vector):
    return np.nanmean(vector)


def increment_by_one(value):
    return value + 1


class PeakTracker:
    """
    Detects peaks in a signal online (as new samples are received), and reports
    average amplitude and inter-peak intervals of the most recent peaks.
    """

    def __init__(self, n_peaks, n_smooth, peak_min):
        """
        :param n_peaks: number of recent peaks over which to report average
          amplitude and interval
        :param n_smooth: number of signal samples to average, to create a
          smoothed signal prior to peak detection (this helps to
          avoid detecting peaks that are just noise)
        :param peak_min: minimum amplitude of peak (smaller peaks are
          ignored)
        """

        self.sample_number = 0
        self.peak_amplitudes = np.array([np.nan] * n_peaks)
        self.peak_times = np.array([np.nan] * n_peaks)
        self.peak_min = peak_min
        self.window = np.array([np.nan] * n_smooth)
        self.last_smoothed_sample = 0
        self.last_change = -1

    def add_sample(self, sample):
        self.sample_number = increment_by_one(self.sample_number)

        # update rolling window
        self.window[:-1] = self.window[1:]
        self.window[-1] = sample

        smoothed_sample = get_nan_mean(self.window)
        change = smoothed_sample - self.last_smoothed_sample

        if smoothed_sample > self.peak_min and self.last_change >= 0 and change < 0:
            print('peak detected at {}'.format(self.sample_number))
            self.peak_amplitudes[:-1] = self.peak_amplitudes[1:]
            self.peak_amplitudes[-1] = smoothed_sample
            self.peak_times[:-1] = self.peak_times[1:]
            self.peak_times[-1] = self.sample_number

        self.last_smoothed_sample = smoothed_sample
        self.last_change = change

    def get_mean_amplitude(self):
        return np.nanmean(self.peak_amplitudes)

    def get_mean_interval(self):
        return get_nan_mean(np.diff(self.peak_times))

