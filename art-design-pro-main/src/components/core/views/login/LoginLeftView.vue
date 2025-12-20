<template>
  <div class="login-left-view" @mousemove="handleMouseMove" @click="handleGlobalClick">
    <!-- 1. 动态流体背景层 (Atmosphere) -->
    <div class="mesh-background">
      <div class="mesh-blob blob-1" :style="blobStyle(20)"></div>
      <div class="mesh-blob blob-2" :style="blobStyle(-20)"></div>
      <div class="mesh-blob blob-3" :style="blobStyle(15)"></div>
    </div>

    <!-- 2. 漂浮的外卖元素层 (Floating Food - 保持原样作为撞色点缀) -->
    <div class="floating-elements">
      <!-- 汉堡 -->
      <div class="float-item item-1" :style="itemStyle(30)">
        <span class="emoji">🍔</span>
      </div>
      <!-- 披萨 -->
      <div class="float-item item-2" :style="itemStyle(-25)">
        <span class="emoji">🍕</span>
      </div>
      <!-- 外卖盒 -->
      <div class="float-item item-3" :style="itemStyle(20)">
        <span class="emoji">🥡</span>
      </div>
      <!-- 饮料 -->
      <div class="float-item item-4" :style="itemStyle(-15)">
        <span class="emoji">🥤</span>
      </div>
      <!-- 摩托车 -->
      <div class="float-item item-5 moto" :style="itemStyle(40)">
        <span class="emoji">🛵</span>
      </div>
    </div>

    <!-- 粒子层 -->
    <div class="particles-container">
       <div 
         v-for="p in particles" 
         :key="p.id" 
         class="particle-emoji"
         :style="{ left: p.x + 'px', top: p.y + 'px' }"
       >
          {{ p.text }}
       </div>
    </div>

    <!-- 3. 噪点纹理层 -->
    <div class="noise-overlay"></div>

    <!-- 4. 前景内容层 -->
    <div class="content-layer">
      <!-- Logo -->
      <div class="logo-area">
        <div class="logo-glass">
          <ArtLogo class="icon" size="36" />
          <h1 class="title">{{ AppConfig.systemInfo.name }}</h1>
        </div>
      </div>

      <!-- 视觉中心：全息送餐雷达 -->
      <div class="visual-center">
        <!-- 速度线 (改为青色) -->
        <div class="speed-lines">
          <div class="line l1"></div>
          <div class="line l2"></div>
          <div class="line l3"></div>
        </div>
        
        <div class="glass-card" :style="cardStyle">
           <!-- 雷达扫描 -->
           <div class="radar-scan">
              <div class="radar-circle c1"></div>
              <div class="radar-circle c2"></div>
              <div class="radar-circle c3"></div>
              <div class="radar-beam"></div>
           </div>
           
           <!-- 中心 3D 元素：智能蓝箱 -->
           <div class="delivery-box-container">
             <div class="delivery-box-3d">
                <div class="box-face front">
                  <span class="logo-icon">🛵</span>
                </div>
                <div class="box-face back"></div>
                <div class="box-face right"></div>
                <div class="box-face left"></div>
                <div class="box-face top"></div>
                <div class="box-face bottom"></div>
             </div>
             <div class="box-shadow"></div>
           </div>

           <!-- 状态标签 -->
           <div class="status-badge">
             <span class="status-dot"></span>
             <span class="status-text">云味道启动</span>
           </div>
        </div>
      </div>

      <!-- 主题切换 -->
      <div class="theme-switch" @click.stop="themeAnimation" title="切换主题">
          <div class="switch-glass">
             <div class="switch-icon"></div>
          </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import AppConfig from '@/config'
import { themeAnimation } from '@/utils/ui/animation'

defineProps<{
  hideContent?: boolean
}>()

// --- 交互逻辑 ---
const mouseX = ref(0)
const mouseY = ref(0)

const handleMouseMove = (e: MouseEvent) => {
  mouseX.value = (e.clientX / window.innerWidth) - 0.5
  mouseY.value = (e.clientY / window.innerHeight) - 0.5
}

interface Particle {
  id: number
  x: number
  y: number
  text: string
}
const particles = ref<Particle[]>([])
let particleId = 0

const handleGlobalClick = (e: MouseEvent) => {
  const emojis = ['❄️', '🧊', '💧', '✨', '🌊', '🥡', '🛵']
  const text = emojis[Math.floor(Math.random() * emojis.length)]
  
  const id = particleId++
  particles.value.push({ id, x: e.clientX - 20, y: e.clientY - 20, text })
  
  setTimeout(() => {
    particles.value = particles.value.filter(p => p.id !== id)
  }, 1000)
}

const blobStyle = (strength: number) => ({
  transform: `translate(${mouseX.value * strength}px, ${mouseY.value * strength}px)`
})

const itemStyle = (strength: number) => ({
  transform: `translate(${mouseX.value * strength * 1.5}px, ${mouseY.value * strength * 1.5}px)`
})

const cardStyle = computed(() => ({
  transform: `
    perspective(1000px)
    rotateY(${mouseX.value * 8}deg)
    rotateX(${mouseY.value * -8}deg)
    translateZ(10px)
  `
}))
</script>

<style lang="scss" scoped>
// --- 配色方案：科技蓝调 (Ocean Blue / Tech Blue) ---
$c-primary: #1890ff;      // 阿里蓝/科技蓝
$c-secondary: #00d2ff;    // 青蓝色
$c-accent: #3a7bd5;       // 深蓝色
$c-bg: #e6f7ff;           // 浅蓝背景
$c-dark-text: #003a8c;    // 深蓝文字

.login-left-view {
  position: relative;
  width: 65vw;
  height: 100%;
  overflow: hidden;
  background-color: $c-bg;
  perspective: 1000px;
  user-select: none;
  cursor: pointer;
  -webkit-tap-highlight-color: transparent;

  // 1. 动态背景层 (蓝色系)
  .mesh-background {
    position: absolute;
    inset: 0;
    z-index: 0;
    filter: blur(80px); 
    
    .mesh-blob {
      position: absolute;
      border-radius: 50%;
      opacity: 0.5;
      animation: float 20s infinite ease-in-out alternate;
    }

    .blob-1 {
      top: -10%; left: -10%; width: 70vw; height: 70vw;
      background: radial-gradient(circle, $c-primary, transparent 70%);
    }

    .blob-2 {
      bottom: -20%; right: -10%; width: 60vw; height: 60vw;
      background: radial-gradient(circle, $c-secondary, transparent 70%);
      animation-delay: -5s;
    }

    .blob-3 {
      top: 40%; left: 30%; width: 40vw; height: 40vw;
      background: radial-gradient(circle, #6dd5fa, transparent 60%);
      animation-delay: -10s;
    }
  }

  // 2. 漂浮元素层
  .floating-elements {
    position: absolute;
    inset: 0;
    z-index: 1;
    pointer-events: none;
    
    .float-item {
      position: absolute;
      font-size: 40px;
      filter: blur(1px);
      opacity: 0.8;
      animation: floatEmoji 15s infinite ease-in-out alternate;
      pointer-events: auto;
      transition: all 0.3s;
      
      &:hover {
         transform: scale(1.5) rotate(15deg) !important;
         opacity: 1;
         filter: blur(0);
         z-index: 100;
         text-shadow: 0 0 20px rgba(24, 144, 255, 0.6); // 蓝色光晕
      }
      
      .emoji {
        display: block;
        animation: spinEmoji 20s infinite linear;
      }

      &.item-1 { top: 15%; left: 15%; font-size: 60px; animation-duration: 18s; }
      &.item-2 { top: 60%; left: 8%; font-size: 45px; animation-duration: 22s; filter: blur(2px); }
      &.item-3 { top: 20%; right: 15%; font-size: 50px; animation-duration: 16s; }
      &.item-4 { bottom: 20%; right: 25%; font-size: 35px; animation-duration: 19s; }
      
      &.moto { 
        top: 50%; right: 10%; font-size: 80px; 
        opacity: 0.6; filter: blur(4px); 
        animation: driveBy 15s infinite linear; 
        
        &:hover {
           animation-duration: 3s;
           opacity: 1;
           filter: blur(0);
        }
      }
    }
  }

  // 粒子
  .particles-container {
     position: absolute;
     inset: 0;
     z-index: 99;
     pointer-events: none;
     .particle-emoji {
        position: absolute;
        font-size: 24px;
        animation: popUp 1s ease-out forwards;
     }
  }

  // 3. 噪点
  .noise-overlay {
    position: absolute;
    inset: 0;
    z-index: 2;
    opacity: 0.04;
    pointer-events: none;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E");
  }

  // 4. 内容层
  .content-layer {
    position: relative;
    z-index: 10;
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 40px;
    box-sizing: border-box;
    pointer-events: none;
    
    .logo-area, .visual-center, .theme-switch {
       pointer-events: auto; 
    }
  }

  // Logo
  .logo-area {
    animation: fadeInDown 1s ease-out;
    display: flex;
    justify-content: space-between;
    
    .logo-glass {
      display: inline-flex;
      align-items: center;
      padding: 12px 24px;
      background: rgba(255, 255, 255, 0.2);
      backdrop-filter: blur(12px);
      border-radius: 40px;
      border: 1px solid rgba(255, 255, 255, 0.3);
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);

      .title {
        margin-left: 12px;
        font-size: 22px;
        font-weight: 700;
        color: $c-dark-text; // 深蓝文字
        letter-spacing: 0.5px;
      }
    }
  }

  // 主题开关
  .theme-switch {
     position: absolute;
     top: 40px;
     right: 40px;
     cursor: pointer;
     z-index: 20;
     
     .switch-glass {
        width: 44px;
        height: 44px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: rgba(255, 255, 255, 0.2);
        backdrop-filter: blur(12px);
        border-radius: 50%;
        border: 1px solid rgba(255, 255, 255, 0.3);
        transition: all 0.3s;
        
        .switch-icon {
           width: 20px;
           height: 20px;
           background: #fff;
           border-radius: 50%;
           box-shadow: 0 0 10px rgba(255,255,255,0.8);
        }
        
        &:hover {
           background: rgba(255, 255, 255, 0.3);
           transform: rotate(30deg);
        }
     }
  }

  // --- 视觉中心 (蓝色科技卡片) ---
  .visual-center {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    
    .speed-lines {
       position: absolute;
       width: 100%; height: 100%; pointer-events: none;
       
       .line {
          position: absolute;
          background: linear-gradient(90deg, transparent, rgba(255,255,255,0.8), transparent);
          height: 2px;
          border-radius: 2px;
          opacity: 0;
          animation: speedLine 3s infinite ease-in-out;
       }
       .l1 { top: 30%; left: 0; width: 200px; animation-delay: 0s; }
       .l2 { top: 60%; right: -50px; width: 150px; animation-delay: 1.5s; }
       .l3 { bottom: 20%; left: 10%; width: 300px; animation-delay: 0.5s; }
    }
    
    .glass-card {
      width: 320px;
      height: 380px; 
      background: rgba(255, 255, 255, 0.15); // 更透明一点
      backdrop-filter: blur(20px);
      border-radius: 40px;
      border: 1px solid rgba(255, 255, 255, 0.25);
      box-shadow: 0 20px 50px rgba(24, 144, 255, 0.15), inset 0 0 20px rgba(255, 255, 255, 0.2); // 蓝色阴影
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      position: relative;
      transition: transform 0.1s ease-out;
      
      &:hover {
         box-shadow: 0 30px 60px rgba(24, 144, 255, 0.25), inset 0 0 30px rgba(255, 255, 255, 0.3);
      }

      // 蓝色雷达
      .radar-scan {
        position: absolute;
        top: 50%; left: 50%;
        transform: translate(-50%, -60%) rotateX(55deg);
        width: 240px; height: 240px; pointer-events: none;

        .radar-circle {
           position: absolute;
           top: 50%; left: 50%; transform: translate(-50%, -50%);
           border-radius: 50%;
           border: 1px solid rgba($c-primary, 0.3); // 蓝边
           box-shadow: 0 0 10px rgba($c-primary, 0.2);
           
           &.c1 { width: 100%; height: 100%; }
           &.c2 { width: 66%; height: 66%; border-color: rgba($c-secondary, 0.5); }
           &.c3 { width: 33%; height: 33%; background: rgba($c-primary, 0.1); }
        }

        .radar-beam {
           position: absolute;
           top: 50%; left: 50%;
           width: 50%; height: 50%;
           background: linear-gradient(90deg, rgba($c-secondary, 0.4), transparent); // 青蓝光束
           transform-origin: top left;
           animation: radarSpin 4s infinite linear;
           border-radius: 100% 0 0 0;
           filter: blur(2px);
        }
      }

      // 3D 蓝箱
      .delivery-box-container {
         position: relative;
         width: 100px; height: 100px;
         transform-style: preserve-3d;
         animation: floatBox 4s ease-in-out infinite;
         margin-bottom: 20px; z-index: 5;
         cursor: pointer;
         
         &:active { transform: scale(0.9); }

         .delivery-box-3d {
            width: 100%; height: 100%; position: relative;
            transform-style: preserve-3d;
            transform: rotateY(-30deg) rotateX(-15deg);
            transition: transform 0.3s;
            &:hover { transform: rotateY(0deg) rotateX(0deg); }
            
            .box-face {
               position: absolute;
               width: 100px; height: 100px;
               background: rgba($c-primary, 0.85); // 科技蓝箱子
               border: 2px solid rgba(255,255,255,0.4);
               display: flex; align-items: center; justify-content: center;
               font-size: 40px; color: #fff;
            }
            
            .front  { transform: translateZ(50px); background: linear-gradient(135deg, $c-primary, $c-secondary); }
            .back   { transform: rotateY(180deg) translateZ(50px); background: darken($c-primary, 10%); }
            .right  { transform: rotateY(90deg) translateZ(50px); background: darken($c-primary, 5%); }
            .left   { transform: rotateY(-90deg) translateZ(50px); background: darken($c-primary, 5%); }
            .top    { transform: rotateX(90deg) translateZ(50px); background: lighten($c-primary, 10%); }
            .bottom { transform: rotateX(-90deg) translateZ(50px); background: darken($c-primary, 20%); }

            .logo-icon { filter: drop-shadow(0 2px 4px rgba(0,0,0,0.2)); }
         }

         .box-shadow {
            position: absolute; bottom: -40px; left: 10%; width: 80%; height: 20px;
            background: rgba(0,0,0,0.2); filter: blur(10px);
            border-radius: 50%; transform: rotateX(60deg);
            animation: shadowPulse 4s ease-in-out infinite;
         }
      }

      // 状态标签
      .status-badge {
         margin-top: 30px;
         background: rgba(255, 255, 255, 0.2);
         padding: 8px 16px; border-radius: 20px;
         display: flex; align-items: center; gap: 8px;
         border: 1px solid rgba(255,255,255,0.3);

         .status-dot {
            width: 8px; height: 8px;
            background: #00e5ff; // 青色光点
            border-radius: 50%;
            box-shadow: 0 0 8px #00e5ff;
            animation: blink 2s infinite;
         }

         .status-text {
            font-size: 16px; 
            font-weight: 800;
            letter-spacing: 2px;
            background: linear-gradient(90deg, #1890ff, #00d2ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 10px rgba(24, 144, 255, 0.2);
            font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif;
         }
      }
    }
  }

  // --- 动画关键帧 ---
  @keyframes popUp {
     0% { transform: scale(0) translateY(0); opacity: 0; }
     50% { opacity: 1; }
     100% { transform: scale(1.5) translateY(-50px); opacity: 0; }
  }

  @keyframes float {
    0% { transform: translate(0, 0) scale(1); }
    50% { transform: translate(5%, 10%) scale(1.1); }
    100% { transform: translate(-5%, -5%) scale(0.95); }
  }

  @keyframes floatEmoji {
    0% { transform: translateY(0) rotate(0deg); }
    100% { transform: translateY(-20px) rotate(10deg); }
  }
  
  @keyframes spinEmoji {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }

  @keyframes driveBy {
    0% { transform: translate(-100px, 100px) scale(0.8); opacity: 0; }
    20% { opacity: 0.6; }
    80% { opacity: 0.6; }
    100% { transform: translate(100px, -100px) scale(1.2); opacity: 0; }
  }

  @keyframes radarSpin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
  @keyframes floatBox { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-15px); } }
  @keyframes shadowPulse { 0%, 100% { transform: scale(1); opacity: 0.2; } 50% { transform: scale(0.8); opacity: 0.1; } }
  @keyframes speedLine { 0% { transform: translateX(-100%) scaleX(0.5); opacity: 0; } 50% { opacity: 1; } 100% { transform: translateX(200%) scaleX(2); opacity: 0; } }
  @keyframes blink { 0%, 100% { opacity: 1; } 50% { opacity: 0.4; } }
  @keyframes fadeInDown { from { opacity: 0; transform: translateY(-30px); } to { opacity: 1; transform: translateY(0); } }

  // --- 响应式 ---
  @media only screen and (width <= 1180px) { display: none; }

  // --- 暗黑模式 ---
  .dark .login-left-view {
    background-color: #001529; // 深蓝黑背景
    
    .mesh-background { opacity: 0.3; }
    
    .logo-glass, .glass-card, .switch-glass, .status-badge {
       background: rgba(0, 0, 0, 0.4);
       border-color: rgba(255, 255, 255, 0.08);
       .title, .status-text { color: #85a5ff; } // 浅蓝字
    }
  }
}
</style>
