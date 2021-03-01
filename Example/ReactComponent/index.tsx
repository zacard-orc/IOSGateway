import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  View,
  Image,
  ImageBackground,
  Text,
  Dimensions,
  PixelRatio,
} from 'react-native';

// import Hello, {Props} from '~/components/Hello';
import Zhibo, {Props} from '~/scene/Zhibo';

const deviceWidth = Dimensions.get('window').width; //设备的宽度
const deviceHeight = Dimensions.get('window').height; //设备的高度
const fontScale = PixelRatio.getFontScale(); //返回字体大小缩放比例
const pixelRatio = PixelRatio.get(); //当前设备的像素密度

console.log('p => ', deviceWidth, deviceHeight, fontScale, pixelRatio);

const RNDemo: React.FC<Props> = () => {
  const arg = {
    name: 'bbbb',
  };
  return (
    <View style={styles.container}>
      {/*<Zhibo {...arg} />*/}
      {/*<Image*/}
      {/*  style={{width: 200, height: 200, borderWidth: 1}}*/}
      {/*  source={require('./play/xiong.png')}*/}
      {/*/>*/}
      {/*<Text style={styles.p1a}>兼容1px</Text>*/}
      {/*<Text style={styles.p1b}>不兼容1px</Text>*/}
      <View style={styles.mockV1}>
        <Text>这是版本2.0.0</Text>
        <Text>发布时间 2020.02.28 21:43:00</Text>
      </View>
    </View>
  );
};
export default RNDemo;

const styles = StyleSheet.create({
  mockV1: {
    height: 100,
    width: '100%',
    marginTop: 100,
    padding: 10,
    textAlign: 'center',
    // backgroundColor: '#FFE890',
    backgroundColor: '#FE837F',
  },
  p1b: {
    marginTop: 20,
    borderWidth: 1,
    borderColor: 'blue',
    padding: 10,
    borderRadius: 5,
  },
  p1a: {
    marginTop: 100,
    borderWidth: 1 / PixelRatio.get(),
    borderColor: 'red',
    padding: 10,
    borderRadius: 5,
  },
  container: {
    marginLeft: 0,
    marginRight: 0,
    marginTop: 0,
    flex: 1,
    height: '100%',
    // maxHeight: 640,
    // backgroundColor: '#aaaaaa',
    borderRadius: 10,
    borderColor: '#000',
    borderWidth: 1,
  },
});

AppRegistry.registerComponent('RNDemo', () => RNDemo);
