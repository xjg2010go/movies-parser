def imageName = 'lucas/movies-parser'

node('workers'){
    stage('Checkout'){
        checkout scm
    }
    def imageTest = docker.build("${imageName}-test","-f Dockerfile.test .")

    stage('Pre-integration Tests'){
        parallel(
            'Quality Tests': {
                imageTest.inside{
                    sh 'golint'
                }
            },
            'Unit Tests': {
                imageTest.inside{
                    sh 'go test'
                }
            },
            'Security Tests': {
                imageTest.inside('-u root:root'){
                    sh 'nancy sleuth -p /go/src/github/mlabouardy/movies-parser/Gopkg.lock'
                }
            }
        )
    }

    stage('Build'){
        docker.build(imageName)
    }
}
