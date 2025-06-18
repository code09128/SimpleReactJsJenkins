pipeline {
  agent any // 使用任何可用的代理節點

  tools {
    // 對應上面設定的名字
    nodejs 'Node24'
  }
  
  environment {
    // 允許在 shell 中直接用這個 node/npm
    PATH = "${tool 'Node24'}/bin:${env.PATH}"
  }

  // 一連串分階段（stage）的任務，每個階段內可以有多個步驟（steps）
  stages {
    stage('Checkout') {
      steps {
        checkout scm // 檢出源碼，使用 Jenkins 預設的 SCM 設定
      }
    }

    stage('Install Dependencies') {
      steps {
        sh 'npm ci' // 使用 npm ci 安裝依賴，執行 npm 的 CI 安裝（依 package-lock.json 精準還原套件）確保使用 package-lock.json
      }
    }

    // 使用 npm test 執行測試
    stage('Run Tests') {
      steps {
        echo 'No tests defined, skipping.' // 如果沒有測試定義，可以跳過這個步驟
        // sh 'npm test -- --watchAll=false' // --watchAll=false 參數確保測試不會進入 watch 模式
      }
    }

    stage('Build') {
      steps {
        sh 'npm run build'
      }
      // 整體 pipeline 執行完後的回呼設定
      post {
        success {
          archiveArtifacts artifacts: 'build/**', fingerprint: true 
        }
      }
    }
  }

  post {
    success {
      echo "✅ React build succeeded!"
    }
    failure {
      echo "❌ React build failed!"
    }
  }
}
