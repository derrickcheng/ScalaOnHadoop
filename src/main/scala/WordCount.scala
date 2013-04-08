import java.io.IOException
import java.util._
import org.apache.hadoop.fs.Path
import org.apache.hadoop.conf._
import org.apache.hadoop.io._
import org.apache.hadoop.mapreduce._
import org.apache.hadoop.util._
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat
import BIDMat.MatFunctions._
import BIDMat.IMat
import scala.reflect.Manifest
import java.io.PrintWriter
import org.apache.commons.cli.Options



object WordCount extends Configured with Tool {

  class Map extends Mapper[LongWritable, Text, Text, IntWritable] {
    var one: IntWritable = new IntWritable(1);
    var word: Text = new Text();
  	
    override def map(key: LongWritable, value: Text, context: Mapper[LongWritable, Text, Text, IntWritable]#Context) {
      var a : IMat = 1\2\3
      var line: String = value.toString();
      var tokenizer: StringTokenizer = new StringTokenizer(line);
      while (tokenizer.hasMoreTokens()) {
        word.set(tokenizer.nextToken());
        context.write(word, one);
      }
    }
  }

  class Reduce extends Reducer[Text, IntWritable, Text, IntWritable] {
    def reduce(key: Text, values: Iterator[IntWritable], context: Reducer[Text, IntWritable, Text, IntWritable]#Context) {
      var sum: Int = 0;
      while (values.hasNext()) {
        sum += values.next().get();
      }
      context.write(key,new IntWritable(sum))
    }
  }
  
  def run(args: Array[String]) =
  {
		  var conf = super.getConf()
//		  Configuration.dumpConfiguration(conf,new PrintWriter(System.out)) // for verfying your conf file 
//	      println("Libjars: " + conf.get("tmpjars")); //for making sure your jars have been include
	      var job : Job = new Job(conf,"WordCount")
	      job
		  job setJarByClass(this.getClass())
	      job setOutputKeyClass classOf[Text]
	      job setOutputValueClass classOf[IntWritable]

	      job setMapperClass classOf[Map]
	      job setCombinerClass classOf[Reduce]
	      job setReducerClass classOf[Reduce]
  	      
  	      FileInputFormat.addInputPath(job, new Path(args(1)))
  	      FileOutputFormat.setOutputPath(job, new Path(args(2)))
  	      job waitForCompletion(true) match {
		    case true => 0
		    case false => 1
		  }
   }
  
  def main(args: Array[String]) {
    var  c : Configuration = new Configuration()
    var res : Int = ToolRunner.run(c,this, args)
    System.exit(res);
  }
  
}