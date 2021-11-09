provider "kubernetes" {

    host                   =  var.host
    client_certificate     =  var.client_certificate
    client_key             =  var.client_key
    cluster_ca_certificate =  var.cluster_ca_certificate
}
resource "kubernetes_deployment" "example"{
    metadata {
    name = "test-aks"
    labels = {
      env = "test"
    }
    }
    spec {
        

        selector {
            match_labels = {
                env = "test"
            }
        }
        template {
            metadata {
                labels = {
                    env = "test"
                }
            }
            spec {
                container {
                    image = "nginx:1.7.8"
                    name  = "app"
                    port  {
                        container_port = 8080
                    }
                }
            }
        } 
    }
}
resource "kubernetes_service" "example" {
  metadata {
    name = "test-aks"
  }
  spec {
    selector = {
      env = "test"
    }
    port {
      port        = 80
      target_port = 8080
      
    }

    type = "LoadBalancer"
  }
}

/*resource "kubernetes_ingress" "example" {
  metadata {
    name = "test-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "addon-http-application-routing"
    }
  }
  spec {
    backend {
      service_name = "test-aks"
      service_port = 80
    }

    rule {
      
      http {
        path {
          backend {
            service_name = "test-aks"
            service_port = 80
          }

          path = "/*"
        }
      }
    }    
  }
} 
*/