import java.io.IOException;
import java.util._;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf._;
import org.apache.hadoop.io._;
import org.apache.hadoop.mapred._;
import org.apache.hadoop.util._;

import scala.reflect.Manifest;

class Map extends MapReduceBase with Mapper[LongWritable, Text, Text, IntWritable] {
    var one: IntWritable = new IntWritable(1);
    var word: Text = new Text();

    def map(key: LongWritable, value: Text, output: OutputCollector[Text, IntWritable], reporter: Reporter) {
      var line: String = value.toString();
      var tokenizer: StringTokenizer = new StringTokenizer(line);
      while (tokenizer.hasMoreTokens()) {
        word.set(tokenizer.nextToken());
        output.collect(word, one);
      }
    }
  }

  class Reduce extends MapReduceBase with Reducer[Text, IntWritable, Text, IntWritable] {
    def reduce(key: Text, values: Iterator[IntWritable], output: OutputCollector[Text, IntWritable], reporter: Reporter) {
      var sum: Int = 0;
      while (values.hasNext()) {
        sum += values.next().get();
      }
      output.collect(key, new IntWritable(sum));
    }
  }

object WordCount extends App{

  override def main(args: Array[String]): Unit =
  {
	      var conf : JobConf = new JobConf();
//  	      conf setJarByClass classOf[WordCount]
	      conf setJobName "wordcount" 
	      conf setOutputKeyClass classOf[Text]
	      conf setOutputValueClass classOf[IntWritable]

	      conf setMapperClass classOf[Map]
	      conf setCombinerClass classOf[Reduce]
	      conf setReducerClass classOf[Reduce]
  	      
  	      FileInputFormat.addInputPath(conf, new Path(args(1)))
  	      FileOutputFormat.setOutputPath(conf, new Path(args(2)))
	      JobClient.runJob(conf);
   }

}