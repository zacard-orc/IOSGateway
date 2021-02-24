import React from 'react';
import {
  Button,
  StyleSheet,
  Text,
  View,
  Dimensions,
  PixelRatio,
  NativeModules,
} from 'react-native';

import Video from 'react-native-video';

// const dp2px = (dp: number) => PixelRatio.getPixelSizeForLayoutSize(dp);
// const px2dp = (px: number) => PixelRatio.roundToNearestPixel(px);
// const {width, height} = Dimensions.get('window');
// const pxRatio = PixelRatio.get();

export interface Props {
  name: string;
}

const Zhibo: React.FC<Props> = (props) => {
  return (
    <View style={styles.vfm}>
      <Video
        source={{uri: 'http://127.0.0.1:5000/test1.mp4'}} // Can be a URL or a local file.
        style={styles.backgroundVideo}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  vfm: {
    borderColor: 'red',
    borderWidth: 1,
    height: '100%',
    width: '100%',
  },
  backgroundVideo: {
    position: 'absolute',
    top: 0,
    left: 0,
    bottom: 0,
    right: 0,
  },
});
export default Zhibo;
