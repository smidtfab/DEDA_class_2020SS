from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

class SentimentAnalyser():

    def __init__(self):
        self.analyser = SentimentIntensityAnalyzer()


    def sentiment_analyzer_scores(self, sentence):
        score = self.analyser.polarity_scores(sentence)
        #print("{:-<40} {}".format(sentence, str(score)))
        return score



if __name__ == "__main__" : 
    analyser = SentimentAnalyser()
    analyser.sentiment_analyzer_scores("This is great")
